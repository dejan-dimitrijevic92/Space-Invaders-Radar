require_relative 'base_error'

class FileNotFoundError < BaseError
  def initialize(filename)
    super("File not found: #{filename}")
  end
end