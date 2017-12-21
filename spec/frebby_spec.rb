# frozen_string_literal: true

#
# Copyright 2017, Ole Claussen <claussen.ole@gmail.com>
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
require 'open3'

describe 'frebby' do
  Dir.glob('examples/*.frb') do |file|
    describe File.basename(file, '.frb') do
      json_file = "#{File.dirname(file)}/#{File.basename(file, '.frb')}.json"

      it 'creates the correct output' do
        @input = File.read(file)
        @expected = File.read(json_file)

        Open3.popen3('frebby') do |stdin, stdout, stderr, wait_thr|
          stdin.write(@input)
          stdin.close

          expect(stderr.read).to be_empty
          expect(wait_thr.value).to eq(0)

          result = JSON.parse(stdout.read)
          expected = JSON.parse(@expected)
          expect(result).to eq(expected)
        end
      end
    end
  end
end
