require_relative 'lib/petfinder/version'

Gem::Specification.new do |spec|
  spec.name          = "petfinder"
  spec.version       = Petfinder::VERSION
  spec.authors       = ["Eric Hutzelman"]
  spec.email         = ["ehutzelman@gmail.com"]

  spec.summary       = "Ruby gem wrapper for the Petfinder API."
  spec.description   = "REST client for the Petfinder published API."
  spec.homepage      = "http://github.com/ehutzelman/petfinder"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://github.com/ehutzelman/petfinder"
  spec.metadata["changelog_uri"] = "https://raw.githubusercontent.com/ehutzelman/petfinder/master/CHANGELOG.md"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "oauth2"
  spec.add_dependency "hashie"

end
