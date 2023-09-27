module Handle
  class Response
    ALLOWED_TYPES = {
      xml: "application/xml",
      json: "application/json",
      jpeg: "image/jpeg",
      png: "image/png",
      form: "multipart/form-data",
      csv: "text/csv",
      html: "text/html"
    }

    def initialize(response)
      @response = response
    end

    def render(headers: {}, status:, type: nil, body: nil)
      set_status(status)
      set_headers(headers)
      set_type(type)

      @response.write(body) if body
    end

    private

    def set_type(type = nil)
      return unless ALLOWED_TYPES.keys.include?(type.to_sym)

      type = ALLOWED_TYPES[type.to_sym]

      @response.content_type = type
    end

    def set_status(status)
      raise ::Exceptions::Handle::ResponseError.new "Invalid status value for #{status}" unless status.is_a? Integer

      @response.status = status
    end

    def set_headers(hash)
      keys = hash.keys
      current_headers = @response.headers

      current_headers.each do |key, value|
        new_value = hash[key]

        return @response.set_headers(key, new_value) if new_value

        @response.delete_header(key)
      end

      keys.each do |key|
        header = @response.get_header(key)
        hash_value = hash[key]

        return if header == hash_value
        return @response.delete_header(key) unless hash_value
      end
    end
  end
end