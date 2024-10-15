require_relative '../../lib/services/file_service'
require_relative '../../lib/errors/file_not_found_error'

RSpec.describe FileService do
  describe '.read_file' do
    context 'when the file exists' do
      let(:file_path) { 'test_file.txt' }
      let(:file_content) { 'Sample file content' }

      before do
        allow(File).to receive(:exist?).with(file_path).and_return(true)
        allow(File).to receive(:read).with(file_path).and_return(file_content)
      end

      it 'returns the content of the file' do
        expect(FileService.read_file(file_path)).to eq(file_content)
      end
    end

    context 'when the file does not exist' do
      let(:file_path) { 'non_existent_file.txt' }

      before do
        allow(File).to receive(:exist?).with(file_path).and_return(false)
      end

      it 'raises a FileNotFoundError' do
        expect { FileService.read_file(file_path) }.to raise_error(FileNotFoundError, "File not found: #{file_path}")
      end
    end
  end
end
