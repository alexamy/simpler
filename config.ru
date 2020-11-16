require_relative 'config/environment'
require_relative 'middleware/http_logger'

use HttpLogger, logdev: File.expand_path('log/app.log', __dir__)
run Simpler.application
