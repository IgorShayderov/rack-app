class RequestValidator
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    if request.path == '/time'
      status, headers, body = @app.call(env)

      [status, headers, body]
    else
      [404, { 'Content-Type' => 'text/html' }, ['Not Found']]
    end
  end
end
