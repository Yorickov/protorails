module Framework
  class Router
    class Route
      attr_reader :controller, :action, :path_name
      attr_accessor :attributes

      def initialize(method, path, controller, action, path_name)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @path_name = path_name
      end

      def match?(method, request_path)
        return false unless @method == method

        pattern =
          @path
          .gsub(/:[^\/]+/) { |match| "(?<#{match[1..-1]}>[\\w-]+)" }
          .gsub('/', '\/')

        match = Regexp.new("^#{pattern}$").match(request_path)
        return false unless match

        self.attributes = match.named_captures
        true
      end

      def generate(name, attributes = {})
        return nil unless @path_name == name

        @path.gsub(/:[^\/]+/) do |match|
          attr = match[1..-1]
          return nil unless attributes.key? attr

          attributes[attr]
        end
      end
    end
  end
end
