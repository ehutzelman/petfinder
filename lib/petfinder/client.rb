module Petfinder
  class Client

    def initialize(api_key = Petfinder.api_key, api_secret = Petfinder.api_secret)
      @api_key, @api_secret = api_key, api_secret
      raise Petfinder::Error.new("API key is required") unless @api_key
    end

    # Valid animal types: barnyard, bird, cat, dog, horse, pig, reptile, smallfurry
    def breeds(animal_type)
      response = perform_get("/breed.list", { :animal => animal_type })
      Breeds.new(response).breeds
    end

    def pet(id)
      response = perform_get("/pet.get", { :id => id })
      Pet.new(response)
    end

    # Options available: animal, breed, size, sex, location, shelterid
    def random_pet(options = {})
      query = options.merge(:output => 'full')
      response = perform_get("/pet.getRandom", query)
      Pet.new(response)
    end

    # Options available: breed, size, sex, age, offset, count
    def find_pets(animal_type, location, options = {})
      query = options.merge(:animal => animal_type, :location => location)
      response = perform_get("/pet.find", query)
      Pet.multiple(response)
    end

    def shelter(id)
      response = perform_get("/shelter.get", { :id => id })
      Shelter.new(response)
    end

    # Options available: name, offset, count
    def find_shelters(location, options = {})
      query = options.merge(:location => location)
      response = perform_get("/shelter.find", query)
      Shelter.multiple(response)
    end

    # Options available: offset, count
    def find_shelters_by_breed(animal_type, breed, options = {})
      query = options.merge(:animal => animal_type, :breed => breed)
      response = perform_get("/shelter.listByBreed", query)
      Shelter.multiple(response)
    end

    # Options available: status, offset, count
    def shelter_pets(id, options = {})
      query = options.merge(:id => id)
      response = perform_get("/shelter.getPets", query)
      Pet.multiple(response)
    end

    def token
      response = perform_get("/auth.getToken", { :sig => digest_key_and_secret })
      Auth.new(response).token
    end

    private

    def digest_key_and_secret
      raise "API secret is required" unless @api_secret
      Digest::MD5.hexdigest(@api_secret + "key=#{@api_key}")
    end

    def perform_get(uri, options = {})
      connection = Excon.new("http://api.petfinder.com", omit_default_port: true)
      response = connection.get(path: uri, query: options.merge(key: @api_key))

      raise "Bad http status response from server: #{response.status}" if response.status != 200
      @xml = Nokogiri::XML(response.body)
      raise "#{petfinder_status_code}: #{petfinder_status_message}" if petfinder_status_code != 100

      @xml
    rescue RuntimeError => ex
      raise Petfinder::Error.new(ex.message)
    end

    def petfinder_status_code
      @xml.xpath("//header/status/code").text.to_i
    end

    def petfinder_status_message
      @xml.xpath("//header/status/message").text
    end

  end
end
