class Request
  # Common set up.
  def initialize(host, port)
    @http = Net::HTTP.new(....)
    @http.use_ssl = true
  end

  # Specific request.
  def execute_request(data)
    # Set up this one request...
    @http.send_request()
  end
end

r = Request.new('host', 70)
r.execute_request('a')
r.execute_request('b')
