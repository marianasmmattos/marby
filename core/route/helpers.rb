module Route
  module Helpers
    def self.included(base)
      def match(method:, path:)
        path = match_path(path)
        match_method(path, method: method)
      end

      def match_path(path)
        path = @paths.find { |pt| pt == path }

        raise ::Exceptions::Route::PathError.new "Route for path #{path} not found" unless path
      
        path
      end

      def match_method(path, method:)
        result = @routes[method]&.find { |route| route[:path] == path }

        raise ::Exceptions::Route::MethodError.new "Method #{method} for path #{path} not found" unless result
      
        result
      end

      def add_route(method:, path:, handler:, action:)
        @routes[method] ||= []
        @routes[method] << { path: path, handler: handler, action: action }
        @paths << path
      end
    end
  end
end