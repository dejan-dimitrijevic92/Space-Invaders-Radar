require_relative 'validator'
require_relative '../errors/invalid_invader_error'

class InvaderValidator < Validator
  def validate!(string)
    raise InvalidInvaderError if nil_or_empty?(string) || !row_lengths_valid?(string) || !contains_valid_characters?(string)
  end
end