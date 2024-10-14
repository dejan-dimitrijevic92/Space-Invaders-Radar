require_relative './errors/file_not_found_error'
require_relative './errors/invalid_radar_error'
require_relative './validators/radar_validator'
require_relative './validators/invader_validator'
require_relative './analyzers/sliding_window_analyzer'
require_relative './models/radar'
require_relative './models/invader'
require_relative 'radar_printer.rb'

class RadarAnalyzer
  def initialize(
    radar_validator: RadarValidator.new,
    invader_validator: InvaderValidator.new,
    analyzer: SlidingWindowAnalyzer.new
  )
    @radar_validator = radar_validator
    @invader_validator = invader_validator
    @analyzer = analyzer
  end

  def analyze_from_file(radar_file, invaders_files, tolerance)
    radar_data = read_file(radar_file)
    invaders_data = invaders_files.map { |file| read_file(file) }

    analyze(radar_data, invaders_data, tolerance)
  end

  def analyze(radar_string, invader_strings, tolerance)
    # Validate radar and invader data
    invader_strings.each { |invader_string| @invader_validator.validate!(invader_string) }
    @radar_validator.validate!(radar_string)

    # Create models
    radar = Radar.new(radar_string)
    invaders = invader_strings.map { |str| Invader.new(str) }

    radar_objects = invaders.map { |invader| invader.variants }.flatten

    # TODO: move printing out of RadarAnalyzer
    invader_hits = @analyzer.analyze(radar, radar_objects, tolerance)
    radar_printer = RadarPrinter.new(radar, invader_hits)
    radar_printer.print

    return invader_hits
  end

  private

  def read_file(file_path)
    raise FileNotFoundError.new(file_path) unless File.exist?(file_path)
    File.read(file_path)
  end
end
