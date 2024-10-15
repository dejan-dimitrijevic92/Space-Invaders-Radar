require_relative '../../lib/models/radar'

RSpec.describe Radar do
  let(:small_radar_string) do
    <<~RADAR
      -oo-
      o--o
      -oo-
      o--o
    RADAR
  end
  

  let(:radar) { Radar.new(small_radar_string) }

  describe '#initialize' do
    it 'parses the radar pattern into a 2D array' do
      expect(radar.pattern).to eq([
        ['-', 'o', 'o', '-'],
        ['o', '-', '-', 'o'],
        ['-', 'o', 'o', '-'],
        ['o', '-', '-', 'o']
      ])
    end

    it 'calculates the correct width and height of the radar' do
      expect(radar.width).to eq(4)
      expect(radar.height).to eq(4)
    end
  end

  describe '#extract_window' do
    context 'when the window is fully within the radar boundaries' do
      it 'extracts the correct window' do
        window = radar.extract_window(1, 1, 2, 2)
        expect(window).to eq([
          ['-', '-'],
          ['o', 'o']
        ])
      end
    end

    context 'when the window goes beyond the radar boundaries' do
      it 'fills the window with nil values for areas outside the radar (top left)' do
        window = radar.extract_window(-1, -1, 3, 3)
        expect(window).to eq([
          [nil, nil, nil],
          [nil, '-', 'o'],
          [nil, 'o', '-']
        ])
      end

      it 'fills the window with nil values for areas outside the radar (bottom right)' do
        window = radar.extract_window(3, 3, 3, 3)
        expect(window).to eq([
          ['o', nil, nil],
          [nil, nil, nil],
          [nil, nil, nil]
        ])
      end

      it 'fills the window with nil values for areas outside the radar (partially overlapping right edge)' do
        window = radar.extract_window(2, 1, 3, 2)
        expect(window).to eq([
          ['-', 'o', nil],
          ['o', '-', nil]
        ])
      end

      it 'fills the window with nil values for areas outside the radar (partially overlapping bottom edge)' do
        window = radar.extract_window(1, 2, 3, 3)
        expect(window).to eq([
          ['o', 'o', '-'],
          ['-', '-', 'o'],
          [nil, nil, nil]
        ])
      end
    end
  end
end
