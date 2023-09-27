module Route
  class Router
    include ::Route::Base
    include ::Route::Helpers

    METHODS = [
      'GET',
      'POST',
      'PATCH',
      'PUTS',
      'DELETE'
    ]

    def initialize
      @routes = {}
      @paths = []
    end

    METHODS.each do |name|
      key = name.downcase.to_sym

      define_method(key) do |path:, action:, handler:|
        add_route(method: name, path: path, action: action, handler: handler)
      end
    end

    def self.route(method:, path:, params:, **args)
      instance.instance_exec do
        route = match(method: method, path: path)

        raise ::Exceptions::Route::RouteError.new "No route found for #{path}" unless route

        route[:handler].new(
          **args
        ).send route[:action].to_sym
      end
    end
  end
end