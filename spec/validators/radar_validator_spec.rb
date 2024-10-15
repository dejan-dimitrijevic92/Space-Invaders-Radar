require_relative '../../lib/validators/radar_validator'
require_relative '../../lib/errors/invalid_radar_error'

RSpec.describe RadarValidator do
  let(:validator) { RadarValidator.new }

  describe '#validate!' do
    context 'when the string is nil' do
      it 'raises an InvalidRadarError' do
        expect { validator.validate!(nil) }.to raise_error(InvalidRadarError)
      end
    end

    context 'when the string is empty' do
      it 'raises an InvalidRadarError' do
        expect { validator.validate!('') }.to raise_error(InvalidRadarError)
      end
    end

    context 'when the row lengths are invalid' do
      it 'raises an InvalidRadarError' do
        invalid_string = "oo\nooo\n"
        expect { validator.validate!(invalid_string) }.to raise_error(InvalidRadarError)
      end
    end

    context 'when the string contains invalid characters' do
      it 'raises an InvalidRadarError' do
        invalid_string = "oo\n@o\n"
        expect { validator.validate!(invalid_string) }.to raise_error(InvalidRadarError)
      end
    end

    context 'when the string is valid' do
      it 'does not raise an error' do
        valid_string = "-oo-\no--o\n-oo-\no--o\n"
        expect { validator.validate!(valid_string) }.not_to raise_error
      end
    end
  end
end
