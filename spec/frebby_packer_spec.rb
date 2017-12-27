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

describe 'frebby | packer' do
  it 'produces valid packer configuration' do
    input = File.read('examples/packer.frb')
    with_external_tool 'packer' do |packer|
      pending 'packer not available' unless packer.available?

      tmpfile = packer.tmpfile('packer.json')
      run_frebby(input, outfile: tmpfile)
      run_packer = packer.run("validate #{tmpfile}")
      expect(run_packer.success?).to eq(true)
    end
  end
end
