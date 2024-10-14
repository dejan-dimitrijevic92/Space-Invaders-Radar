require_relative './lib/radar_analyzer'
require_relative './lib/errors/file_not_found_error'
require_relative './lib/errors/invalid_radar_error'
require_relative './lib/errors/invalid_invader_error'

begin
  radar_file_path = 'data/radar/radar_image.txt'
  invader_file_paths = ['data/invaders/invader1.txt', 'data/invaders/invader2.txt']
  noice_tollerance = 0.2
  radar_analyzer = RadarAnalyzer.new
  radar_analyzer.analyze_from_file(radar_file_path, invader_file_paths, noice_tollerance)

rescue FileNotFoundError => e
  puts e.message
rescue InvalidRadarError, InvalidInvaderError => e
  puts 'Invalid data:'
  puts e.message
rescue StandardError => e
  puts "An unexpected error occurred: #{e.message}"
  puts e.backtrace.join("\n") 
end
