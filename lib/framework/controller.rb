require_relative 'view'

module Framework
  class Controller
    attr_reader :name, :request, :response

    def initialize(request, response)
      @name = extract_name
      @request = request
      @response = response
    end

    def make_response(action)
      @request.env['framework.controller'] = self
      @request.env['framework.action'] = action

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render
    end

    def render(template)
      @request.env['framework.template'] = template
    end
  end
end
