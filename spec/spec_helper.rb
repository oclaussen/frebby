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
require 'open3'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.warnings = true
  config.order = :random
  config.default_formatter = 'doc'

  Kernel.srand config.seed
end

def each_example
  Dir.glob 'examples/*.frb' do |frb_file|
    dir = File.dirname(frb_file)
    name = File.basename(frb_file, '.frb')
    json_file = File.join(dir, "#{name}.json")
    yield name, frb_file, json_file if block_given?
  end
end

def run_frebby(input)
  Open3.popen3('frebby') do |stdin, stdout, stderr, wait_thr|
    stdin.write(input)
    stdin.close

    error = stderr.read
    success = wait_thr.value.success?
    raise error unless success && error.empty?

    return stdout.read
  end
end
