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
require 'tmpdir'

describe 'frebby | packer' do
  it 'produces valid packer configuration' do
    Dir.mktmpdir do |path|
      generated = run_frebby(File.read('examples/packer.frb'))
      tmpfile = File.new(File.join(path, 'packer.json'), 'w')
      tmpfile.write(generated)
      tmpfile.close

      run_packer = system("packer validate #{tmpfile.path}")
      expect(run_packer).to eq(true)
    end
  end
end
