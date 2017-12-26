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

describe 'frebby' do
  each_example do |name, frb_file, json_file|
    describe name do
      it 'matches the expected JSON file' do
        input = File.read(frb_file)
        expected = JSON.parse(File.read(json_file))
        result = JSON.parse(run_frebby(input))
        expect(result).to eq(expected)
      end
    end
  end
end
