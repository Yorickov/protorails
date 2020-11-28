require_relative 'config/environment'

use Rack::Reloader
use Framework::AppLogger

run Framework.application
