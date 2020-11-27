module Framework
  class Controller
    def initialize(request, response)
      @request = request
      @response = response
    end

    def make_response(action)
      send(action)
    end
  end
end
