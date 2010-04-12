module Petfinder
  
  class Client
    include HTTParty
    format :xml
    base_uri "http://api.petfinder.com"
    
    def initialize(api_key = Petfinder.api_key, api_secret = Petfinder.api_secret)
      @api_key, @api_secret = api_key, api_secret
      raise "API key is required" if @api_key.blank?

      self.class.default_params :key => api_key
    end
    
    # Valid animal types: barnyard, bird, cat, dog, horse, pig, reptile, smallfurry
    def breeds(animal_type)
      response = perform_get("/breed.list", :query => {:animal => animal_type})
      return_as_array(response.breeds.breed)
    end    

    def pet(id)
      response = perform_get("/pet.get", :query => {:id => id})
      response.pet
    end
    
    # Options available: animal, breed, size, sex, location, shelterid 
    def random_pet(options = {})
      response = perform_get("/pet.getRandom", :query => {:output => 'full'})
      response.pet
    end
    
    # Options available: breed, size, sex, age, offset, count
    def find_pets(animal_type, location, options = {})
      query = options.merge(:animal => animal_type, :location => location)
      response = perform_get("/pet.find", :query => query)
      return_as_array(response.pets.pet)
    end

    def shelter(id)
      response = perform_get("/shelter.get", :query => {:id => id})
      response.shelter      
    end
    
    # Options available: name, offset, count
    def find_shelters(location, options = {})
      query = options.merge(:location => location)
      response = perform_get("/shelter.find", :query => query)
      return_as_array(response.shelters.shelter)
    end

    # Options available: offset, count    
    def find_shelters_by_breed(animal_type, breed, options = {})
      query = options.merge(:animal => animal_type, :breed => breed)
      response = perform_get("/shelter.listByBreed", :query => query)
      return_as_array(response.shelters.shelter)
    end
    
    # Options available: status, offset, count
    def shelter_pets(id, options = {})
      query = options.merge(:id => id)
      response = perform_get("/shelter.getPets", :query => query)
      return_as_array(response.pets.pet)
    end
    
    def token
      response = perform_get("/auth.getToken", :query => {:sig => digest_key_and_secret})
      response.auth.token
    end
        
    private
    
    def return_as_array(object)
      object.class == Array ? object : [object]
    end
    
    def digest_key_and_secret      
      raise "API secret is required" if @api_secret.blank?
      Digest::MD5.hexdigest(@api_secret + "key=#{@api_key}")
    end

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