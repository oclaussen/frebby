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

describe 'frebby | terraform' do
  it 'produces valid terraform configuration' do
    input = File.read('examples/terraform.frb')
    with_external_tool 'terraform' do |terraform|
      pending 'terraform not available' unless terraform.available?

      run_frebby(input, outfile: terraform.tmpfile('terraform.tf.json'))
      terraform.run('init -backend=false')
      run_terraform = terraform.run('validate')
      expect(run_terraform.success?).to eq(true)
    end
  end
end
