require_relative 'base_error'

class InvalidInvaderError < BaseError
  def initialize
    super('Invader format is invalid')
  end
end