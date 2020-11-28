require 'json'

module Framework
  class JsonRenderer < Renderer
    def content_type
      'application/json'
    end

    def render(content)
      content.to_json
    end
  end
end
