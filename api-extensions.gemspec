# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'api/extensions/version'

Gem::Specification.new do |spec|
  spec.name          = 'api-extensions'
  spec.version       = Api::Extensions::VERSION
  spec.authors       = ['Nahuel Cuesta Luengo']
  spec.email         = ['nahuelcuestaluengo@gmail.com']
  spec.description   = %q{Extensions for Hypermedia-driven APIs}
  spec.summary       = %q{A collection of extensions for Hypermedia-driven APIs}
  spec.homepage      = 'https://github.com/ncuesta/api-extensions'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'cucumber'

  spec.add_dependency 'json', '~> 1.8.0'
end
