require_relative 'base_error'

class InvalidRadarError < BaseError
  def initialize
    super('Radar format is invalid')
  end
end