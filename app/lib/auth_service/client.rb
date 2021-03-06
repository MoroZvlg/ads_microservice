require 'dry/initializer'
require_relative 'api'

module AuthService
  class Client
    BASE_URL = "http://localhost:3010".freeze
    extend Dry::Initializer[undefined: false]
    include Api

    option :url, default: proc { BASE_URL }
    option :connection, default: proc { build_connection }
    option :token


    def request(method:, path:, params: {}, body: {})
      response = @connection.run_request method, "/auth/v1/#{path}", body, nil do |req|
        req.params.update params
        req.headers["Authorization"] = "Bearer #{@token}"
        req.headers["X_REQUEST_ID"] = Thread.current[:request_id]
      end
      response.body
    end

    def build_connection
      Faraday.new(@url) do |conn|
        conn.use ErrorsMiddleware, {}
        conn.request :json
        conn.response :json, content_type: /\bjson$/

        conn.adapter Faraday.default_adapter
      end
    end
  end
end