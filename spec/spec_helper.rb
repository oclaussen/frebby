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
require 'open3'
require 'tmpdir'

module Helpers
  class ExternalTool
    def initialize(path, available, tmpdir)
      @path = path
      @available = available
      @tmpdir = tmpdir
    end

    def available?
      @available
    end

    def tmpfile(name)
      File.join(@tmpdir, name)
    end

    def run(command)
      Dir.chdir @tmpdir do
        Open3.popen3 "#{@path} #{command}" do |_, _, _, wait_thr|
          return wait_thr.value
        end
      end
    end
  end

  def run_frebby(input, outfile: nil)
    Open3.popen3 'frebby' do |stdin, stdout, stderr, wait_thr|
      stdin.write(input)
      stdin.close

      error = stderr.read
      raise error unless wait_thr.value.success? && error.empty?

      return stdout.read if outfile.nil?
      tmpfile = File.new(outfile, 'w')
      tmpfile.write(stdout.read)
      tmpfile.close
    end
  end

  def with_external_tool(tool_name)
    Open3.popen3 "command -v #{tool_name};" do |_, stdout, stderr, wait_thr|
      available = wait_thr.value.success? && stderr.read.empty?
      tool_path = stdout.read.strip
      Dir.mktmpdir do |tmpdir|
        yield ExternalTool.new(tool_path, available, tmpdir) if block_given?
      end
    end
  end

  def expected_output_for(frb_file)
    basename = File.basename(frb_file, '.frb')
    dir = File.dirname(frb_file)
    json_file = File.join(dir, "#{basename}.json")
    File.read(json_file)
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.warnings = true
  config.order = :random
  config.default_formatter = 'doc'
  config.include Helpers

  Kernel.srand config.seed
end
