require_relative 'validator'
require_relative '../errors/invalid_radar_error'

class RadarValidator < Validator
  def validate!(string)
    raise InvalidRadarError if nil_or_empty?(string) || !row_lengths_valid?(string) || !contains_valid_characters?(string)
  end
end