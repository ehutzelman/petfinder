require 'petfinder'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :should
  end
end

def fixture_file(filename)
  File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
end

def stub_get(url, filename)
  stub_request(:get, url).to_return(body: fixture_file(filename), status: 200)
end
