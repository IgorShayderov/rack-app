class GetTime
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    formats = request.params['format'].split(',')
    formatted_time = body(formats)

    response.status = formatted_time.include?("Unknown time format") ? 400 : 200
    headers.each { |header_key, header_value| response.set_header(header_key, header_value)}
    response.write formatted_time

    response.finish
  end

  private

  def headers
    { 'Content-Type' => 'text/plain'}
  end

  def body(formats)
    unknown_formats = []
  
    handled_formats = formats.map do |format|
      send(format)
    rescue NoMethodError => error
      unknown_formats << format
    end

    if unknown_formats.any?
      "Unknown time format #{unknown_formats}\n"
    else
      "#{handled_formats.join('-')}\n"
    end
  end

  def year
    '1970'
  end

  def month
    '01'
  end

  def day
    '01'
  end

  def hour
    '12'
  end

  def minute
    '05'
  end

  def second
    '58'
  end
end
