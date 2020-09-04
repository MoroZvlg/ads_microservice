require 'dry/initializer'
require_relative 'api'

module GeoRabbitService
  class Client
    extend Dry::Initializer[undefined: false]
    include Api

    option :queue, default: proc { create_queue }
    option :lock, default: proc { Mutex.new }
    option :condition, default: proc { ConditionVariable.new }
    option :response, default: proc { nil }

    def self.fetch
      Thread.current["ads_service.rabbit_client"] ||= self.new.start
    end

    def start
      callback_queue.subscribe do |_delivery_info, properties, payload|
        if properties[:correlation_id] == @correlation_id
          @response = JSON.parse(payload)
          lock.synchronize { condition.signal }
        end
      end
      self
    end

    def create_queue
      channel = RabbitMq.channel
      channel.queue("geocoding", durable: true)
    end

    def callback_queue
      channel = RabbitMq.channel
      channel.queue("amq.rabbitmq.reply-to", durable: true)
    end

    private

    attr_writer :correlation_id

    def publish_and_wait(payload, options = {})
      self.correlation_id = SecureRandom.uuid

      lock.synchronize do
        @queue.publish(
            payload,
            options.merge({persistent: true,
                           app_id: "ads",
                           reply_to: callback_queue.name,
                           correlation_id: @correlation_id})
        )
        condition.wait(lock)
      end

      response
    end



  end
end