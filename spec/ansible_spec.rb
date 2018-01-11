# frozen_string_literal: true

require 'json'

describe 'frebby' do
  context 'ansible' do
    Dir.glob 'examples/presets/ansible/*.frb' do |file|
      it "produces expected JSON for #{File.basename(file)}" do
        input = File.read(file)
        expected = JSON.parse(expected_output_for(file))
        result = JSON.parse(run_frebby(input))
        expect(result).to eq(expected)
      end

      it 'produces valid ansible configuration' do
        input = File.read(file)
        with_external_tool 'ansible-playbook' do |ansible|
          pending 'ansible not available' unless ansible.available?
          tmpfile = ansible.tmpfile('playbook.json')
          run_frebby(input, outfile: tmpfile)
          run_ansible = ansible.run("--syntax-check #{tmpfile}")
          expect(run_ansible.success?).to eq(true)
        end
      end
    end
  end
end
