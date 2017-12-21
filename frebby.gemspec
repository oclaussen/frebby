# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name           = 'frebby'
  spec.version        = '0.0.1'
  spec.author         = 'Ole Claussen'
  spec.email          = 'claussen.ole@gmail.com'
  spec.license        = 'Apache-2.0'
  spec.summary        = 'JSON generator'
  spec.homepage       = 'https://github.com/oclaussen/frebby'

  spec.files          = Dir['lib/**/*.rb'] + Dir['bin/*']
  spec.require_paths  = ['lib']
  spec.bindir         = 'bin'
  spec.executables    = ['frebby']

  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rubocop', '~> 0.52'
end
