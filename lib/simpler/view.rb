require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      @env['simpler.template_name'] = template_name

      template = File.read(template_path)

      ERB.new(template).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def template_name
      path = template || [controller.name, action].join('/')
      "#{path}.html.erb"
    end

    def template_path
      Simpler.root.join(VIEW_BASE_PATH, template_name)
    end

  end
end
