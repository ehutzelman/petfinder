require 'excon'
require 'nokogiri'
require 'digest/md5'

require 'petfinder/client'
require 'petfinder/xml_mapper'
require 'petfinder/pet'
require 'petfinder/breeds'
require 'petfinder/shelter'
require 'petfinder/auth'

module Petfinder

  class Error < StandardError; end

  class << self
    attr_accessor :api_key, :api_secret
  end

  def self.configure
    yield self
    true
  end

end

