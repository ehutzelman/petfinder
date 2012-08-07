$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'petfinder'
require 'rspec'
require 'fakeweb'
require 'active_support/core_ext/object/blank'

def fixture_file(filename)
  File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
end

def stub_get(url, filename, options={})
  opts = {:body => fixture_file(filename)}.merge(options)

  FakeWeb.register_uri(:get, url, opts)
end