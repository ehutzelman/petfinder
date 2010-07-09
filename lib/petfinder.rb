require 'httparty'
require 'happymapper'
require 'digest/md5'

module Petfinder
  
  class PetfinderError < StandardError; end

  class << self
    attr_accessor :api_key, :api_secret
  end
  
  def self.configure
    yield self
    true
  end

end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'petfinder', 'client')
require File.join(directory, 'petfinder', 'pet')
require File.join(directory, 'petfinder', 'breeds')
require File.join(directory, 'petfinder', 'shelter')
require File.join(directory, 'petfinder', 'auth')