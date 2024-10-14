class Radar
  attr_reader :pattern, :width, :height

  def initialize(string)
    @pattern = string.strip.split("\n").map(&:chars)
    @height = @pattern.size
    @width = @pattern.empty? ? 0 : @pattern.first.size
  end

  def extract_window(x, y, window_width, window_height)
    window = Array.new(window_height) { Array.new(window_width) }
    
    (0...window_height).each do |dy|
      (0...window_width).each do |dx|
        radar_y = y + dy
        radar_x = x + dx
        # Check if within bounds of the radar
        if radar_y.between?(0, height - 1) && radar_x.between?(0, width - 1)
          window[dy][dx] = pattern[radar_y][radar_x]
        end
      end
    end

    window
  end
end