# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'petfinder/version'

Gem::Specification.new do |s|
  s.name              = "petfinder"
  s.rubyforge_project = "petfinder"
  s.version           = Petfinder::VERSION
  s.authors           = ["Eric Hutzelman"]
  s.email             = ["ehutzelman@gmail.com"]
  s.homepage          = "http://github.com/ehutzelman/petfinder"
  s.summary           = "Ruby gem wrapper for the Petfinder API."
  s.description       = "REST client for the Petfinder published API."

  s.add_dependency('happymapper', ["~> 0.3.2"])
  s.add_dependency('httparty', ["~> 0.5.0"])
  s.add_development_dependency('rspec', ["~> 2.0.pre"])
  s.add_development_dependency('fakeweb', ["~> 1.2.5"])

  # Standard
  s.required_rubygems_version = ">= 1.3.6"
  s.platform         = Gem::Platform::RUBY
  s.require_paths    = ["lib"]
  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables      = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.extra_rdoc_files = %w[README.rdoc LICENSE]
  s.rdoc_options     = ["--charset=UTF-8"]
end
