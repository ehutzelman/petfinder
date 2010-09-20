Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  ## Leave these as is they will be modified for you by the rake gemspec task.
  ## If your rubyforge_project name is different, then edit it and comment out
  ## the sub! line in the Rakefile
  s.name              = 'petfinder'
  s.version           = '0.1.0'
  s.date              = '2010-09-20'
  s.rubyforge_project = 'petfinder'

  ## Make sure your summary is short. The description may be as long
  ## as you like.
  s.summary     = "Ruby gem wrapper for the Petfinder API."
  #s.description = "Long description. Maybe copied from the README."

  ## List the primary authors. If there are a bunch of authors, it's probably
  ## better to set the email to an email list or something. If you don't have
  ## a custom homepage, consider using your GitHub URL or the like.
  s.authors  = ["Eric Hutzelman"]
  s.email    = 'ehutzelman@gmail.com'
  s.homepage = 'http://github.com/ehutzelman/petfinder'

  ## This gets added to the $LOAD_PATH so that 'lib/NAME.rb' can be required as
  ## require 'NAME.rb' or'/lib/NAME/file.rb' can be as require 'NAME/file.rb'
  s.require_paths = %w[lib]

  ## This sections is only necessary if you have C extensions.
  # s.require_paths << 'ext'
  # s.extensions = %w[ext/extconf.rb]

  ## If your gem includes any executables, list them here.
  # s.executables = ["name"]
  # s.default_executable = 'name'

  ## Specify any RDoc options here. You'll want to add your README and
  ## LICENSE files to the extra_rdoc_files list.
  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.rdoc LICENSE]

  ## List your runtime dependencies here. Runtime dependencies are those
  ## that are needed for an end user to actually USE your code.
  s.add_dependency('happymapper', [">= 0.3.2"])
  s.add_dependency('httparty', [">= 0.5.0"])

  ## List your development dependencies here. Development dependencies are
  ## those that are only needed during development
  s.add_development_dependency('rspec', [">= 2.0.pre"])
  s.add_development_dependency('fakeweb', [">= 1.2.5"])

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    Gemfile
    LICENSE
    README.rdoc
    Rakefile
    VERSION
    lib/petfinder.rb
    lib/petfinder/auth.rb
    lib/petfinder/breeds.rb
    lib/petfinder/client.rb
    lib/petfinder/pet.rb
    lib/petfinder/shelter.rb
    petfinder.gemspec
    spec/fixtures/auth.xml
    spec/fixtures/breed_list.xml
    spec/fixtures/pet.xml
    spec/fixtures/pet_list.xml
    spec/fixtures/shelter.xml
    spec/fixtures/shelter_list.xml
    spec/petfinder_spec.rb
    spec/spec_helper.rb
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files = s.files.select { |path| path =~ /^spec\/.*_spec\.rb/ }
end
