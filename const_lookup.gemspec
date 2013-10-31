# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'const_lookup/version'

Gem::Specification.new do |spec|
  spec.name          = 'const_lookup'
  spec.version       = ConstLookup::VERSION
  spec.authors       = ["Andrew Marshall"]
  spec.email         = ["andrew@johnandrewmarshall.com"]
  spec.description   = %q{Makes resolving a constant in a given namespace easy.}
  spec.summary       = %q{Makes resolving a constant in a given namespace easy.}
  spec.homepage      = 'http://johnandrewmarshall.com/projects/const_lookup'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
