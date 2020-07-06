module AuthService
  class ErrorsMiddleware < Faraday::Response::Middleware

    SUCCESS_STATUSES = (200..299).freeze
    def initialize(app, options)
      super(app)
      @options = options
    end

    def on_complete(env)
      unless SUCCESS_STATUSES.include?(env.status)
        pp env.body #log_errors
        raise Exceptions::AuthException.new
      end
    end

  end
end
