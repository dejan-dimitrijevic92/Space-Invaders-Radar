require 'rainbow'
require 'pry'

class RadarPrinter
  def initialize(radar, radar_object_hits)
    @radar = radar
    @radar_object_hits = radar_object_hits
  end

  def print
    radar_copy = deep_copy(@radar.pattern)

    @radar_object_hits.each do |hit|
      apply_hit(radar_copy, hit)
    end

    puts radar_copy.map { |row| row.join }.join("\n")
  end

  private

  def apply_hit(radar_copy, hit)
    radar_object = hit[:radar_object]

    (0...radar_object.height).each do |i|
      (0...radar_object.width).each do |j|
        radar_y = hit[:y] + i
        radar_x = hit[:x] + j
        next unless within_bounds?(radar_y, radar_x, radar_copy)

        radar_copy[radar_y][radar_x] = Rainbow(radar_copy[radar_y][radar_x]).green
      end
    end
  end

  def within_bounds?(y, x, radar_copy)
    y >= 0 && y < radar_copy.size && x >= 0 && x < radar_copy[0].size
  end

  def deep_copy(obj)
    Marshal.load(Marshal.dump(obj))
  end
end