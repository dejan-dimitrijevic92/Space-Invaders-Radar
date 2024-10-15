require_relative '../../lib/validators/invader_validator'
require_relative '../../lib/errors/invalid_invader_error'

RSpec.describe InvaderValidator do
  let(:validator) { InvaderValidator.new }

  describe '#validate!' do
    context 'when the string is nil' do
      it 'raises an InvalidInvaderError' do
        expect { validator.validate!(nil) }.to raise_error(InvalidInvaderError)
      end
    end

    context 'when the string is empty' do
      it 'raises an InvalidInvaderError' do
        expect { validator.validate!('') }.to raise_error(InvalidInvaderError)
      end
    end

    context 'when the row lengths are invalid' do
      it 'raises an InvalidInvaderError' do
        invalid_string = "oo\nooo\n"
        expect { validator.validate!(invalid_string) }.to raise_error(InvalidInvaderError)
      end
    end

    context 'when the string contains invalid characters' do
      it 'raises an InvalidInvaderError' do
        invalid_string = "oo\n@o\n"
        expect { validator.validate!(invalid_string) }.to raise_error(InvalidInvaderError)
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
