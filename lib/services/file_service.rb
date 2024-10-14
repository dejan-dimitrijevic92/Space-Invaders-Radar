require_relative '../errors/file_not_found_error'

class FileService
  def self.read_file(file_path)
    raise FileNotFoundError.new(file_path) unless File.exist?(file_path)
    File.read(file_path)
  end
end