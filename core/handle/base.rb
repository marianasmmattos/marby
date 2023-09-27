module Handle
  class Base
    def self.call
      Proc.new do |env|
        request = Rack::Request.new(env)
        response = Rack::Response.new

        yield(
          request: ::Handle::Request.new(request),
          response: ::Handle::Response.new(response)
        )
      
        response.finish
      end
    end
  end
end
