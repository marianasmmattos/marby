module Handle
  class Request
    ALLOWED_TYPES = [
      "application/xml",
      "application/json",
      "image/jpeg",
      "image/png",
      "multipart/form-data",
      "text/csv",
      "text/html"
    ]

    def initialize(request)
      @request = request
    end

    def valid_type?
      type = @request.content_type
      
      return unless type

      allowed = ALLOWED_TYPES.include?(type.split(';').first)
      
      raise ::Handle::RequestError.new "Content-type not allowed" unless allowed
    end

    def params
      @params ||= get_params
    end

    def method
      stringfy_method
    end

    def path
      @request.path
    end

    def headers
      headers = {}

      @request.each_header do |key, value|
        headers[key] = value
      end

      headers
    end

    private

    def stringfy_method
      @request.request_method
    end

    def get_params
      params = JSON.parse(@request.body.read)
      params = params.merge(@request.params)     

      ::Handle::ParamsParser.call(params)
    end
  end
end