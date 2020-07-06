
module AuthService
  module Api

    def auth
      response = request(method: :post, path: 'auth')
      response.dig("meta", "user_id")
    end
  end
end