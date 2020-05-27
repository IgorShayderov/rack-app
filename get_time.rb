require_relative 'format_time'

class GetTime
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    formats = request.params['format'].split(',')
    formatted_time = response_body(formats)

    response.status = formatted_time.include?('Unknown time format') ? 400 : 200
    headers.each { |header_key, header_value| response.set_header(header_key, header_value)}
    response.write formatted_time

    response.finish
  end

  private

  def headers
    { 'Content-Type' => 'text/plain'}
  end

  def response_body(formats)
    formatter = FormatTime.new(formats)

    if formatter.valid?
      formatter.time
    else
      formatter.invalid_formats
    end
  end
end
