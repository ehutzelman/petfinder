require 'rubygems'
require 'httparty'
require 'hashie'
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