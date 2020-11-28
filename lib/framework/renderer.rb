module Framework
  class Renderer
    class << self
      def types
        {
          plain: PlainRenderer,
          html: HtmlRenderer,
          js: JsRenderer,
          json: JsonRenderer,
          xml: XmlRenderer
        }
      end

      def create(type)
        types[type].new
      end
    end

    def render(content)
      content
    end
  end
end
