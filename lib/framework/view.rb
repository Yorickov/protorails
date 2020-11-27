module Framework
  class View
    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render
      File.read(template_path)
    end

    private

    def controller
      @env['framework.controller']
    end

    def action
      @env['framework.action']
    end

    def template
      @env['framework.template']
    end

    def template_path
      path = template || [controller.name, action].join('/')

      Framework.root.join(VIEW_BASE_PATH, "#{path}.html")
    end
  end
end
