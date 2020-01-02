# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'petfinder/version'

Gem::Specification.new do |spec|
  spec.name          = "petfinder"
  spec.version       = Petfinder::VERSION
  spec.authors       = ["Eric Hutzelman"]
  spec.email         = ["ehutzelman@gmail.com"]
  spec.description   = "REST client for the Petfinder published API."
  spec.summary       = "Ruby gem wrapper for the Petfinder API."
  spec.homepage      = "http://github.com/ehutzelman/petfinder"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "excon", "> 0.26"
  spec.add_dependency "nokogiri", "> 1.6"
end
