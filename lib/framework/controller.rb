require_relative 'view'
require_relative 'renderer'

module Framework
  class Controller
    attr_reader :name, :request, :response

    def initialize(request, response)
      @name = extract_name
      @request = request
      @response = response
    end

    def make_response(action, attributes)
      request.env['framework.controller'] = self
      request.env['framework.action'] = action
      request.env['framework.attributes'] = attributes

      set_default_headers
      send(action)
      write_response

      response.finish
    end

    def status(status_code)
      response.status = status_code
    end

    def headers
      response
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def params
      request.params.merge(@request.env['framework.attributes'])
    end

    def set_default_headers
      headers['Content-Type'] = 'text/html'
    end

    def write_response
      body = request.env['framework.body'] || render_default_body

      response.write(body)
    end

    def render_default_body
      View.new(request.env).render(binding)
    end

    def render(template)
      template.is_a?(Hash) ? set_raw_body(template) : set_default_body(template)
    end

    def set_raw_body(opts)
      require_renderers

      render_type, body = opts.to_a[0]
      renderer = Renderer.create(render_type)

      headers['Content-Type'] = renderer.content_type
      request.env['framework.body'] = renderer.render(body)
    end

    def set_default_body(template)
      request.env['framework.template'] = template
    end

    def require_renderers
      Dir["#{__dir__}/renderers/**/*.rb"].sort.each { |file| require file }
    end
  end
end
