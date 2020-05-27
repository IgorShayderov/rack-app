require 'date'

class FormatTime
  TIME_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(formats)
    @current_time = DateTime.now
    @invalid_formats = []
    @handled_formats = stringify_formats(formats)
  end

  def stringify_formats(formats)
    handle_formats(formats).join('-')
  end

  def handle_formats(formats)
    formats.map do |format|
      TIME_FORMATS[format] || (@invalid_formats << format)
    end
  end

  def valid?
    p @invalid_formats
    @invalid_formats.empty?
  end

  def time
    "Time now: #{@current_time.strftime(@handled_formats)}\n"
  end

  def invalid_formats
    "Unknown time format #{@invalid_formats}\n"
  end
end
