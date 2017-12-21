# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop)
RSpec::Core::RakeTask.new(:rspec)

task default: %i[clean rubocop rspec]
task all: %i[clean rubocop rspec build]
