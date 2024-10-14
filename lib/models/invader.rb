require_relative 'radar_object'

class Invader
  attr_reader :pattern, :variants

  def initialize(string)
    @pattern = string.strip.split("\n").map(&:chars)
    @variants = generate_variants
  end

  def generate_variants
    base_variant = RadarObject.new(@pattern)
    [
      base_variant,
      base_variant.rotate_90,
      base_variant.rotate_180,
      base_variant.rotate_270
    ]
  end
end