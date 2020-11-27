require 'singleton'

module Framework
  class Application
    include Singleton

    def call(_env)
      [
        200,
        { 'Content-Type' => 'text/plain' },
        ["Go, rails!\n"]
      ]
    end
  end
end
