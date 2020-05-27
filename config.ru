require_relative 'get_time'
require_relative 'middleware/request_validator'

use RequestValidator
run GetTime.new
