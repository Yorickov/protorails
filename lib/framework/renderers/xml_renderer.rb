require 'gyoku'

module Framework
  class XmlRenderer < Renderer
    def content_type
      'application/xml'
    end

    def render(content)
      Gyoku.xml(content)
    end
  end
end
