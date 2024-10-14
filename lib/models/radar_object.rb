class RadarObject
  attr_reader :pattern, :width, :height, :area

  def initialize(pattern)
    @pattern = pattern
    @height = pattern.size
    @width = pattern.first.size
    @area = @height * @width 
  end

  def rotate_90
    rotated = @pattern.transpose.map(&:reverse)
    RadarObject.new(rotated)
  end

  def rotate_180
    rotated = @pattern.reverse.map(&:reverse)
    RadarObject.new(rotated)
  end

  def rotate_270
    rotated = @pattern.transpose.reverse
    RadarObject.new(rotated)
  end
end
