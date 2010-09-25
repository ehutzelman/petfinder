# -*- encoding: utf-8 -*-
require File.expand_path("../lib/petfinder/version", __FILE__)

Gem::Specification.new do |s|
  s.name              = "petfinder"
  s.rubyforge_project = "petfinder"
  s.version           = Petfinder::VERSION
  s.authors           = ["Eric Hutzelman"]
  s.email             = ["ehutzelman@gmail.com"]
  s.homepage          = "http://github.com/ehutzelman/petfinder"
  s.summary           = "Ruby gem wrapper for the Petfinder API."
  s.description       = "REST client for the Petfinder published API."

  # Dependencies (pullled into Gemfile with "gemspec")
  s.add_dependency "happymapper", "~> 0.3.2"
  s.add_dependency "httparty", "~> 0.5.0"
  s.add_development_dependency "rspec", "~> 2.0.pre"
  s.add_development_dependency "fakeweb", "~> 1.2.5"
  s.add_development_dependency "bundler", ">= 1.0.0"

  # Standard setup that should not need modification
  s.required_rubygems_version = ">= 1.3.6"
  s.platform      = Gem::Platform::RUBY
  s.require_path  = 'lib'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact

  s.extra_rdoc_files = %w[README.rdoc LICENSE]
  s.rdoc_options     = ["--charset=UTF-8"]
end
