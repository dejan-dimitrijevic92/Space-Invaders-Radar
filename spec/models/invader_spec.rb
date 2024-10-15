require_relative '../../lib/models/invader'

RSpec.describe Invader do
  let(:invader_string) do
    " oo\n--\n "
  end

  let(:invader) { Invader.new(invader_string) }

  describe '#initialize' do
    it 'initializes with the correct pattern' do
      expected_pattern = [
        ['o', 'o'],
        ['-', '-']
      ]
      expect(invader.pattern).to eq(expected_pattern)
    end
  end

  describe '#generate_variants' do
    it 'generates the base variant' do
      expect(invader.variants[0].pattern).to eq([['o', 'o'], ['-', '-']])
    end

    it 'generates the 90-degree rotated variant' do
      expect(invader.variants[1].pattern).to eq([['-', 'o'], ['-', 'o']])
    end

    it 'generates the 180-degree rotated variant' do
      expect(invader.variants[2].pattern).to eq([['-', '-'], ['o', 'o']])
    end

    it 'generates the 270-degree rotated variant' do
      expect(invader.variants[3].pattern).to eq([['o', '-'], ['o', '-']])
    end
  end
end
