# frozen_string_literal: true

require 'json'

describe 'frebby' do
  context 'known quirks and issues' do
    Dir.glob 'examples/04_quirks/*.frb' do |file|
      it "produces expected JSON for #{File.basename(file)}" do
        input = File.read(file)
        expected = JSON.parse(expected_output_for(file))
        result = JSON.parse(run_frebby(input))
        expect(result).to eq(expected)
      end
    end
  end
end
