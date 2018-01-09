# frozen_string_literal: true

#
# Copyright 2018, Ole Claussen <claussen.ole@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
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
