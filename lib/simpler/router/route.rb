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

      def inject_params!(env, path)
        match_data = @path.match(path)
        env['Url-Params'] = match_data.named_captures.transform_keys!(&:to_sym)
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
