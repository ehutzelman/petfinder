require 'oauth2'
require 'hashie'
require 'petfinder/api'
require 'petfinder/mash'
require 'petfinder/client'

module Petfinder

  API_URL = "https://api.petfinder.com/v2"

  class Error < StandardError
    attr_reader :data
    def initialize(data)
      @data = data
      super
    end
  end

  class << self
    attr_accessor :api_key, :api_secret
  end

  def self.configure
    yield self
    true
  end

end
