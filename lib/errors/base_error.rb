class BaseError < StandardError
 def initialize(message = '')
  super(message)
 end
end