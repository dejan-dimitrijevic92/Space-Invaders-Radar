require_relative '../../lib/models/radar_object'

RSpec.describe RadarObject do
  let(:pattern) do
    [
      ['o', 'o', '-'],
      ['-', 'o', 'o'],
      ['o', '-', '-']
    ]
  end

  let(:radar_object) { RadarObject.new(pattern) }

  describe '#initialize' do
    it 'initializes with the correct pattern, height, width, and area' do
      expect(radar_object.pattern).to eq(pattern)
      expect(radar_object.height).to eq(3)
      expect(radar_object.width).to eq(3)
      expect(radar_object.area).to eq(9)
    end
  end

  describe '#rotate_90' do
    it 'rotates the pattern by 90 degrees' do
      rotated_pattern = [
        ['o', '-', 'o'],
        ['-', 'o', 'o'],
        ['-', 'o', '-']
      ]
      expect(radar_object.rotate_90.pattern).to eq(rotated_pattern)
    end
  end

  describe '#rotate_180' do
    it 'rotates the pattern by 180 degrees' do
      rotated_pattern = [
        ['-', '-', 'o'],
        ['o', 'o', '-'],
        ['-', 'o', 'o']
      ]
      expect(radar_object.rotate_180.pattern).to eq(rotated_pattern)
    end
  end

  describe '#rotate_270' do
    it 'rotates the pattern by 270 degrees' do
      rotated_pattern = [
        ['-', 'o', '-'],
        ['o', 'o', '-'],
        ['o', '-', 'o']
      ]
      expect(radar_object.rotate_270.pattern).to eq(rotated_pattern)
    end
  end
end
