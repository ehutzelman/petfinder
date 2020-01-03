require "bundler/setup"
require 'petfinder'
# require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def fixture_file(filename)
  File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
end

def stub_get(url, filename)
  stub_request(:get, url).to_return(body: fixture_file(filename), status: 200, headers: { 'Content-Type'=> 'application/json;charset=UTF-8' })
end

def stub_post(url, filename)
  stub_request(:post, url).to_return(body: fixture_file(filename), status: 200, headers: { 'Content-Type'=> 'application/json;charset=UTF-8' })
end
