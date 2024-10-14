require_relative './lib/invader_radar_analyzer'
require_relative './lib/radar_printer'
require_relative './lib/services/file_service'
require_relative './lib/errors/file_not_found_error'
require_relative './lib/errors/invalid_radar_error'
require_relative './lib/errors/invalid_invader_error'

begin
  radar_file_path = 'data/radar/radar_image2.txt'
  invader_file_paths = ['data/invaders/invader1.txt', 'data/invaders/invader2.txt']
  noice_tollerance = 0.2
  
  radar_data = FileService.read_file(radar_file_path)
  invaders_data = invader_file_paths.map { |file| FileService.read_file(file) }
  
  radar_analyzer = InvaderRadarAnalyzer.new(radar_data, invaders_data, noice_tollerance)
  positions = radar_analyzer.analyze
  
  # Print nice output with invaders locations colored
  radar_printer = RadarPrinter.new(radar_analyzer.radar, positions)
  radar_printer.print
  
  # Print postions if needed
  # positions.each do |position|
  #   puts "X: #{position[:x]}, Y: #{position[:y]}"
  # end

rescue FileNotFoundError => e
  puts e.message
rescue InvalidRadarError, InvalidInvaderError => e
  puts 'Invalid data:'
  puts e.message
rescue StandardError => e
  puts "An unexpected error occurred: #{e.message}"
  puts e.backtrace.join("\n") 
end
