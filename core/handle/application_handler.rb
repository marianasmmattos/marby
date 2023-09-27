class ApplicationHandler
  def initialize(request:, response:, database: nil)
    @request = request
    @response = response
    @database = database
    @request.valid_type?
  end

  def params
    @request.params
  end

  def path
    @request.path
  end

  def method
    @request.method
  end

  def headers
    @request.headers
  end

  def render(**args)
    @response.render(**args)
  end

  def database
    @database
  end
end
