require 'singleton'
require_relative 'router'
require_relative 'controller'

module Framework
  class Application
    include Singleton

    def initialize
      @router = Router.new
    end

    def bootstrap!
      require_controllers
      require_routes
    end

    def routes(&block)
      @router.instance_eval(&block)
    end

    def call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new

      route = @router.find_route(request)
      if route
        controller = route.controller.new(request, response)
        action = route.action

        make_response(controller, action)
      else
        make_exception(404, 'Not Found')
      end
    end

    private

    def require_controllers
      Dir["#{Framework.root}/app/**/*.rb"]
        .sort
        .each { |file| require file }
    end

    def require_routes
      require Framework.root.join('config/routes')
    end

    def make_response(controller, action)
      controller.make_response(action)
    end

    def make_exception(error_status, message)
      [error_status, { 'Content-Type' => 'text/plain' }, [message]]
    end
  end
end
