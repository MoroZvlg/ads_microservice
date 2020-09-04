module AuthRabbitService
  module Api

    def auth(token)
      payload = { token: token }.to_json
      publish_and_wait(payload, type: "auth")
    end

  end
end