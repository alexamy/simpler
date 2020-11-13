require 'logger'

class HttpLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    response = @app.call(env)
    status, headers, body = response

    method = env['REQUEST_METHOD']
    uri = env['REQUEST_URI']

    controller = env['simpler.controller']
    action = env['simpler.action']
    template = env['simpler.template_name']

    @logger.info("Request: #{method} #{uri}")
    @logger.info("Handler: #{controller.class.name}##{action}")
    @logger.info("Params: #{controller.send(:params)}")
    @logger.info("Response: #{status} [#{headers['Content-Type']}] #{template}")

    response
  end
end
