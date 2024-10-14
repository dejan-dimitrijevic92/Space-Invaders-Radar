require_relative 'analyzer'
require 'pry'

class SlidingWindowAnalyzer < Analyzer
  # Allowable percentage of visible object on edges for detection
  MIN_PARTIAL_PERCENTAGE = 0.5
  MIN_VISIBLE_WIDTH = 0.5
  MIN_VISIBLE_HEIGHT = 0.5

  def analyze(radar, objects, tolerance)
    object_hits = []

    objects.each do |radar_object|
      radar_object_width = radar_object.width
      radar_object_height = radar_object.height
  
      (-radar_object_width / 2..(radar.width + radar_object_width / 2)).each do |x|
        (-radar_object_height / 2..(radar.height + radar_object_height / 2)).each do |y|
          window = radar.extract_window(x, y, radar_object_width, radar_object_height)
  
          object_hits << { radar_object: radar_object, x: x, y: y } if partial_match?(window, radar_object, tolerance)
        end
      end
    end

    object_hits
  end

  private

  def partial_match?(window, radar_object, tolerance)
    return false if window.nil? || window.empty?

    visible_cells = window.flatten.count { |cell| cell }
    total_cells = radar_object.area

    return false unless visibility_criteria_met?(visible_cells, total_cells)

    matches_with_tolerance?(window, radar_object, tolerance, visible_cells)
  end

  def visibility_criteria_met?(visible_cells, total_cells)
    visible_width_percentage = visible_cells.to_f / total_cells
    visible_height_percentage = visible_cells.to_f / total_cells

    visible_width_percentage >= MIN_VISIBLE_WIDTH && visible_height_percentage >= MIN_VISIBLE_HEIGHT && visible_cells >= total_cells * MIN_PARTIAL_PERCENTAGE
  end

  def matches_with_tolerance?(window, radar_object, tolerance, effective_area)
    match_count = window.each_with_index.sum do |row, y|
      row.each_with_index.count do |cell, x|
        cell == radar_object.pattern[y][x] if cell
      end
    end

    minimum_required_matches = (1 - tolerance) * effective_area
    match_count.to_f >= minimum_required_matches
  end
end
