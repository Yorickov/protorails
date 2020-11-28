require 'logger'

module Framework
  class AppLogger
    def initialize(app)
      @logger = Logger.new(Framework.root.join('log/app.log'))
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)

      @logger.info request_log(request)
      @logger.info params_log(request)
      @logger.info handler_log(request)

      status, headers, body = @app.call(env)
      @logger.info response_log(request, status, headers)

      [status, headers, body]
    end

    private

    def request_log(request)
      "Request: #{[request.request_method, request.fullpath].join(' ')}"
    end

    def params_log(request)
      "Parameters: #{request.params}"
    end

    def handler_log(request)
      route = @app.router.match(request)

      body =
        if route
          [route.controller.name, route.action].join('#')
        else
          'No such a route'
        end

      "Handler: #{body}"
    end

    def response_log(request, status, headers)
      body_type = "[#{headers['Content-type']}]"

      status_message = Rack::Utils::HTTP_STATUS_CODES[status]

      response_content = [status, status_message, body_type]

      if !request.env['framework.body'] && status == 200
        path = request.env['framework.template'] ||
               [request.env['framework.controller'].name,
                request.env['framework.action']].join('/')

        template = "#{path}.html.erb"
        response_content << template
      end

      "Response: #{response_content.join(' ')}"
    end
  end
end
