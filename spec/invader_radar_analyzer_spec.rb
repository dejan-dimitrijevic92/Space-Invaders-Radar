require_relative '../lib/invader_radar_analyzer'

RSpec.describe InvaderRadarAnalyzer do
  let(:radar_string) do
    <<~RADAR
      -o--
      o--o
      -oo-
      o--o
    RADAR
  end

  let(:invader_strings) do
    [
      <<~INVADER
        oo
        oo
      INVADER
    ]
  end

  let(:tolerance) { 0.5 }

  let(:analyzer) { InvaderRadarAnalyzer.new(radar_string, invader_strings, tolerance) }

  describe '#initialize' do
    context 'when valid inputs are provided' do
      it 'initializes successfully' do
        expect(analyzer).to be_instance_of(InvaderRadarAnalyzer)
      end

      it 'creates a radar object' do
        expect(analyzer.radar).to be_instance_of(Radar)
      end

      it 'creates invader objects' do
        expect(analyzer.instance_variable_get(:@invaders)).not_to be_empty
        expect(analyzer.instance_variable_get(:@invaders).first).to be_instance_of(Invader)
      end
    end

    context 'when invalid radar string is provided' do
      let(:invalid_radar_string) { 'invalid_radar' }

      it 'raises an InvalidRadarError' do
        expect {
          InvaderRadarAnalyzer.new(invalid_radar_string, invader_strings, tolerance)
        }.to raise_error(InvalidRadarError)
      end
    end

    context 'when invalid invader strings are provided' do
      let(:invalid_invader_strings) do
        [
          <<~INVADER
            ooo
            o
          INVADER
        ]
      end

      it 'raises an error for invalid invader strings' do
        expect {
          InvaderRadarAnalyzer.new(radar_string, invalid_invader_strings, tolerance)
        }.to raise_error(InvalidInvaderError, 'Invader format is invalid')
      end
    end
  end

  describe '#analyze' do
    context 'when analyzing the radar with invaders' do
      it 'returns detection results' do
        results = analyzer.analyze
        expect(results).not_to be_empty
        expect(results.first).to include(:radar_object)
      end

      it 'detects multiple invaders' do
        additional_invader = <<~INVADER
          oo
          oo
        INVADER

        analyzer_with_multiple_invaders = InvaderRadarAnalyzer.new(radar_string, [invader_strings.first, additional_invader], tolerance)
        results = analyzer_with_multiple_invaders.analyze

        expect(results.size).to be >= 1
      end
    end

    context 'when no invader matches' do
      let(:non_matching_invader_strings) do
        [
          <<~INVADER
            oo
            oo
          INVADER
        ]
      end

      it 'returns empty results' do
        tolerance = 0.1
        analyzer_with_no_match = InvaderRadarAnalyzer.new(radar_string, non_matching_invader_strings, tolerance)
        results = analyzer_with_no_match.analyze

        expect(results).to be_empty
      end
    end
  end
end
