require_relative './errors/invalid_radar_error'
require_relative './validators/radar_validator'
require_relative './validators/invader_validator'
require_relative './analyzers/sliding_window_analyzer'
require_relative './models/radar'
require_relative './models/invader'
require_relative 'radar_printer.rb'

class InvaderRadarAnalyzer
  attr_reader :radar

  def initialize(
    radar_string,
    invader_strings,
    tolerance,
    radar_validator: RadarValidator.new,
    invader_validator: InvaderValidator.new,
    analyzer: SlidingWindowAnalyzer.new
  )
    @radar_validator = radar_validator
    @invader_validator = invader_validator
    @analyzer = analyzer
    @tolerance = tolerance
    
    validate_inputs(radar_string, invader_strings)
    create_models(radar_string, invader_strings)
  end

  def analyze
    radar_objects = @invaders.map { |invader| invader.variants }.flatten
    return @analyzer.analyze(@radar, radar_objects, @tolerance)
  end
  
  private

  def validate_inputs(radar_string, invader_strings)
    invader_strings.each { |invader_string| @invader_validator.validate!(invader_string) }
    @radar_validator.validate!(radar_string)
  end
  
  def create_models(radar_string, invader_strings)
    @radar = Radar.new(radar_string)
    @invaders = invader_strings.map { |str| Invader.new(str) }
  end
end
