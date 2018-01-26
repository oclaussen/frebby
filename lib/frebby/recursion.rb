# frozen_string_literal: true

require 'json'
require 'open3'

class Frebby
  class << self
    def read_file(filename)
      source = caller_locations(1..1).first.absolute_path
      current_dir = source == '-' ? Dir.pwd : File.dirname(source)
      file = File.expand_path(filename, current_dir)
      raise "File #{file} does not exist" unless File.exist?(file)
      raise "Could not read file #{file}" unless File.readable?(file)
      JSON.parse run_recursive(file)
    end

    def read_text(text)
      JSON.parse run_recursive(stdin_text: text)
    end

    private

    def run_recursive(*args, stdin_text: nil)
      args.unshift $PROGRAM_NAME
      Open3.popen3 args.join(' ') do |stdin, stdout, stderr, thread|
        stdin.write stdin_text unless stdin_text.nil?
        stdin.close
        error = stderr.read
        status = thread.value
        raise error unless status.success? && error.empty?
        stdout.read
      end
    end
  end
end
