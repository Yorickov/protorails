require_relative 'router/route'

module Framework
  class Router
    attr_reader :routes

    def initialize
      @routes = []
    end

    def get(path, handler, path_name)
      add_route(:get, path, handler, path_name)
    end

    def post(path, handler, path_name)
      add_route(:post, path, handler, path_name)
    end

    def match(request)
      method = request.request_method.downcase.to_sym
      path = request.path_info

      routes.find { |route| route.match?(method, path) }
    end

    def generate(name, attributes = {})
      routes.each do |route|
        url = route.generate(name, attributes)
        return url if url
      end
      nil
    end

    private

    def add_route(method, path, handler, path_name)
      controller_name, action = handler.split('#')
      controller = controller_from_string(controller_name)
      route = Route.new(method, path, controller, action, path_name)

      routes.push(route)
    end

    def controller_from_string(controller_name)
      Object.const_get("#{controller_name.capitalize}Controller")
    end
  end
end
