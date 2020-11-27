module Framework
  class Controller
    def initialize(request, response)
      @request = request
      @response = response
    end

    def make_response(action)
      send(action)
    end

    def index
      [
        200,
        { 'Content-Type' => 'text/plain' },
        ["All articles\n"]
      ]
    end

    def create
      [
        201,
        { 'Content-Type' => 'text/plain' },
        ["Article created\n"]
      ]
    end
  end
end
