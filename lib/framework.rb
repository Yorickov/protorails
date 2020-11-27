require 'pathname'
require_relative 'framework/application'

module Framework
  class << self
    def application
      Application.instance
    end

    def root
      Pathname.new(File.expand_path('..', __dir__))
    end
  end
end
