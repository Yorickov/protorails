require_relative 'router/route'

module Framework
  class Router
    def initialize
      @routes = []
    end

    def get(path, handler)
      add_route(:get, path, handler)
    end

    def post(path, handler)
      add_route(:post, path, handler)
    end

    def find_route(request)
      method = request.request_method.downcase.to_sym
      path = request.path_info

      @routes.find { |route| route.match?(method, path) }
    end

    private

    def add_route(method, path, handler)
      action = handler.split('#').last
      route = Route.new(method, path, Controller, action)

      @routes.push(route)
    end
  end
end
