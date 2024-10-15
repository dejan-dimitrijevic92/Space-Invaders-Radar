require_relative '../../lib/analyzers/sliding_window_analyzer'
require_relative '../../lib/models/radar'
require_relative '../../lib/models/radar_object'
require_relative '../../lib/errors/invalid_radar_error'

RSpec.describe SlidingWindowAnalyzer do
  let(:radar) do
    radar_string = <<~RADAR
      -o--
      o--o
      -oo-
      o--o
    RADAR
    Radar.new(radar_string)
  end

  let(:radar_object) do
    object_pattern = <<~OBJECT
      oo
      oo
    OBJECT
    RadarObject.new(object_pattern.strip.split("\n").map(&:chars))
  end

  let(:analyzer) { SlidingWindowAnalyzer.new }

  describe '#analyze' do
    context 'when radar pattern matches the object with noise and tolerance allows it' do
      it 'detects the object' do
        tolerance = 0.5
        results = analyzer.analyze(radar, [radar_object], tolerance)
        expect(results).not_to be_empty
        expect(results.first[:radar_object]).to eq(radar_object)
      end
    end

    context 'when radar pattern does not match the object and exceeds tolerance' do
      it 'does not detect the object' do
        tolerance = 0.1
        results = analyzer.analyze(radar, [radar_object], tolerance)
        expect(results).to be_empty
      end
    end

    context 'when radar pattern matches part of the object at the edge' do
      let(:radar) do
        radar_string = <<~RADAR
          o---
          o--o
          -o--
          o--o
        RADAR
        Radar.new(radar_string)
      end

      it 'detects valid partial position of the object' do
        tolerance = 0.1
        results = analyzer.analyze(radar, [radar_object], tolerance)
        expect(results.size).to eq(1)
        expect(results).to contain_exactly({ radar_object: radar_object, x: -1, y: 0 })
      end
    end

    context 'when radar pattern does not contain the object at all' do
      it 'does not detect the object' do
        non_matching_object = RadarObject.new(["xx", "xx"].map(&:chars))
        results = analyzer.analyze(radar, [non_matching_object], 0.1)
        expect(results).to be_empty
      end
    end

    context 'when radar contains multiple positions of the object' do
      let(:radar) do
        radar_string = <<~RADAR
          -o--
          oo-o
          -o--
          o--o
        RADAR
        Radar.new(radar_string)
      end
    
      let(:radar_object) do
        object_pattern = <<~OBJECT
          oo
          oo
        OBJECT
        RadarObject.new(object_pattern.strip.split("\n").map(&:chars))
      end

      it 'detects all positions of the object' do
        tolerance = 0.3
        results = analyzer.analyze(radar, [radar_object], tolerance)

        expect(results.size).to eq(2)
        expect(results).to contain_exactly(
          { radar_object: radar_object, x: 0, y: 0 },
          { radar_object: radar_object, x: 0, y: 1 }
        )
      end
    end
  end
end
