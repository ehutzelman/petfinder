module Petfinder
  
  class Client
    include HTTParty
    format :xml
    base_uri "http://api.petfinder.com"
    
    def initialize(api_key = Petfinder.api_key, api_secret = Petfinder.api_secret)
      raise "API key is required" if api_key.blank?
      
      self.class.default_params :key => api_key
    end
    
    # valid animal types: barnyard, bird, cat, dog, horse, pig, reptile, smallfurry
    def breeds(animal_type)
      response = perform_get("/breed.list", :query => {:animal => animal_type})
      response.breeds.breed
    end    

    def random_pet
      response = perform_get("/pet.getRandom", :query => {:output => 'full'})
      response.pet
    end
    
    private
    
    def perform_get(uri, options = {})
      response = self.class.get(uri, options)
      raise_errors(response)
      mash = Hashie::Mash.new(response['petfinder'])
    end
    
    def raise_errors(response)
      if response.code.to_i == 200
        status = response['petfinder']['header']['status']
        raise PetfinderError.new("(#{status['code']}) #{status['message']}") if status['code'].to_i != 100
      else
        raise RuntimeError.new("Invalid response from server: #{response.code}")
      end
    end
    
  end
  
end