# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name           = 'frebby'
  spec.version        = '1.0.1'
  spec.author         = 'Ole Claussen'
  spec.email          = 'claussen.ole@gmail.com'
  spec.license        = 'Apache-2.0'
  spec.summary        = 'vs. JSON'
  spec.description    = <<~DESCRIPTION
    `frebby` is a very, very simple Ruby script that generates JSON out of a Ruby
    based configuration language. It is intended as an alternative to the numerous
    attempts to write a more human-readable language for tool configuration (YAML,
    TOML, HCL, to name a few).
  DESCRIPTION
  spec.homepage       = 'https://github.com/oclaussen/frebby'

  spec.require_paths  = ['lib']
  spec.bindir         = 'bin'
  spec.executables    = ['frebby']
  spec.files          = Dir['lib/**/*.rb'] + 
                        Dir['bin/*'] +
                        Dir['*.gemspec'] + 
                        %w[LICENSE README.md Gemfile Rakefile]

  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rubocop', '~> 0.52'
end
