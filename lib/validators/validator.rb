class Validator
  def validate!(string)
    raise NotImplementedError, 'Validator must implement validate! method'
  end

  protected

  def nil_or_empty?(string)
    return string.nil? || string.strip.empty?
  end

  def row_lengths_valid?(string)
    row_lengths = string.split("\n").map(&:length)
    return row_lengths.uniq.size == 1
  end

  def contains_valid_characters?(string)
    return string.match?(/^[\-o\s]+$/)
  end
end