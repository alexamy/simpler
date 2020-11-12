module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = make_path(path)
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && @path =~ path
      end

      private

      def make_path(path)
        regex_s = path.split('/')
          .map { |part| part.start_with?(':') ? "(?<#{part[1..]}>[a-z0-9]+)" : part }
          .join('/') + '$'

        Regexp.new(regex_s, Regexp::IGNORECASE)
      end

    end
  end
end
