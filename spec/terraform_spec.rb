# frozen_string_literal: true

require 'json'

describe 'frebby' do
  context 'terraform' do
    Dir.glob 'examples/03_presets/terraform/*.frb' do |file|
      it "produces expected JSON for #{File.basename(file)}" do
        input = File.read(file)
        expected = JSON.parse(expected_output_for(file))
        result = JSON.parse(run_frebby(input))
        expect(result).to eq(expected)
      end

      it 'produces valid terraform configuration' do
        input = File.read(file)
        with_external_tool 'terraform' do |terraform|
          pending 'terraform not available' unless terraform.available?
          run_frebby(input, outfile: terraform.tmpfile('terraform.tf.json'))
          terraform.run('init -backend=false')
          run_terraform = terraform.run('validate')
          expect(run_terraform.success?).to eq(true)
        end
      end
    end
  end
end
