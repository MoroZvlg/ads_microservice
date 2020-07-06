module Auth
  AUTH_TOKEN = %r{\ABearer (?<token>.+)\z}

  def user_id
    auth_client.auth
  end

  private

  def auth_client
    @auth_client ||= AuthService::Client.new(token: matched_token)
  end

  def matched_token
    result = auth_header&.match(AUTH_TOKEN)
    return if result.blank?

    result[:token]
  end

  def auth_header
    request.env["HTTP_AUTHORIZATION"]
  end
end
