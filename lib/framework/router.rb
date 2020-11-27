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
      controller_name, action = handler.split('#')
      controller = controller_from_string(controller_name)
      route = Route.new(method, path, controller, action)

      @routes.push(route)
    end

    def controller_from_string(controller_name)
      Object.const_get("#{controller_name.capitalize}Controller")
    end
  end
end
