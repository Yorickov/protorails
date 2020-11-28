require 'rubygems'
require 'bundler/setup'

require 'pathname'
require_relative 'framework/application'
require_relative 'framework/middleware/logger'

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
