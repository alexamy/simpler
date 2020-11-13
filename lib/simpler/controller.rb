require_relative 'view'
require_relative 'utils/headers'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def params
      @request.params.merge(@request.env['Url-Params'])
    end

    def render(data)
      if data.is_a?(String)
        @request.env['simpler.template'] = data
      else
        @request.env['simpler.template.type'] = data.keys.first
        @request.env['simpler.template.data'] = data.values.first
      end
    end

    def status(code)
      @response.status = code
    end

    def headers
      Headers.new(@response)
    end
  end
end
