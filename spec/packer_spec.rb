# frozen_string_literal: true

require 'json'

describe 'frebby' do
  context 'packer' do
    Dir.glob 'examples/presets/packer/*.frb' do |file|
      it "produces expected JSON for #{File.basename(file)}" do
        input = File.read(file)
        expected = JSON.parse(expected_output_for(file))
        result = JSON.parse(run_frebby(input))
        expect(result).to eq(expected)
      end

      it 'produces valid packer configuration' do
        input = File.read(file)
        with_external_tool 'packer' do |packer|
          pending 'packer not available' unless packer.available?
          tmpfile = packer.tmpfile('packer.json')
          run_frebby(input, outfile: tmpfile)
          run_packer = packer.run("validate #{tmpfile}")
          expect(run_packer.success?).to eq(true)
        end
      end
    end
  end
end
