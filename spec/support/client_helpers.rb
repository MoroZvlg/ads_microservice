module ClientHelpers
  def auth_connection
    Faraday.new(@url) do |conn|
      conn.use described_service::ErrorsMiddleware, {}
      conn.request :json
      conn.response :json, content_type: /\bjson$/

      conn.adapter :test, stubs
    end
  end

  def stubs
    @stubs ||= Faraday::Adapter::Test::Stubs.new
  end

  def described_service
    described_class.name.split("::").first.constantize
  end
end