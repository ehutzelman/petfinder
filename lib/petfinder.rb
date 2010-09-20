require 'httparty'
require 'happymapper'
require 'digest/md5'

require 'petfinder/client'
require 'petfinder/pet'
require 'petfinder/breeds'
require 'petfinder/shelter'
require 'petfinder/auth'

module Petfinder
  VERSION = '0.1.0'

  class PetfinderError < StandardError; end

  class << self
    attr_accessor :api_key, :api_secret
  end

  def self.configure
    yield self
    true
  end

end

