class Radar
  attr_reader :pattern, :width, :height

  def initialize(string)
    @pattern = string.strip.split("\n").map(&:chars)
    @height = @pattern.size
    @width = @pattern.empty? ? 0 : @pattern.first.size
  end

  def extract_window(x, y, window_width, window_height)
    # Define limits for boundary checking
    x_start = [x, 0].max
    y_start = [y, 0].max
    x_end = [x + window_width - 1, width - 1].min
    y_end = [y + window_height - 1, height - 1].min

    # Initialize window with nil values
    window = Array.new(window_height) { Array.new(window_width, nil) }

    # Copy valid radar values into the window
    (y_start..y_end).each_with_index do |radar_y, dy|
      (x_start..x_end).each_with_index do |radar_x, dx|
        window[dy + (y_start - y)][dx + (x_start - x)] = pattern[radar_y][radar_x]
      end
    end

    window
  end
end
