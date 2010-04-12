require 'helper'

class TestPetfinder < Test::Unit::TestCase

  context "When working with the Petfinder API" do
    setup do
      @client = Petfinder::Client.new('1234567', 'mysekrit')
    end

    should "get a random pet" do
      stub_get("http://api.petfinder.com/pet.getRandom?key=1234567&output=full", "pet.xml")
      pet = @client.random_pet
      assert_equal 'Charlie', pet.name
    end
    
    should "get a specific pet by id" do
      stub_get("http://api.petfinder.com/pet.get?key=1234567&id=123", "pet.xml")
      pet = @client.pet(123)
      assert_equal 'Charlie', pet.name      
    end
    
    should "find pets matching a query" do
      stub_get("http://api.petfinder.com/pet.find?key=1234567&animal=dog&location=77007", "pet_list.xml")
      pets = @client.find_pets('dog', '77007')
      assert_equal 'Petey', pets.first.name
    end
    
    should "get the list of breeds for the given animal type" do
      stub_get("http://api.petfinder.com/breed.list?key=1234567&animal=horse", "breed_list.xml")
      breeds = @client.breeds('horse')
      assert_equal 'Appaloosa', breeds.first
    end

    should "get a specific shelter by id" do
      stub_get("http://api.petfinder.com/shelter.get?key=1234567&id=123", "shelter.xml")
      shelter = @client.shelter(123)
      assert_equal 'Lucky Dog Rescue', shelter.name      
    end

    should "find shelters matching a query" do
      stub_get("http://api.petfinder.com/shelter.find?key=1234567&location=77007", "shelter_list.xml")
      shelters = @client.find_shelters('77007')
      assert_equal 'Pup Squad Animal Rescue', shelters.first.name
    end

    should "find shelters matching a breed" do
      stub_get("http://api.petfinder.com/shelter.listByBreed?key=1234567&animal=horse&breed=arabian", "shelter_list.xml")
      shelters = @client.find_shelters_by_breed('horse', 'arabian')
      assert_equal 'Pup Squad Animal Rescue', shelters.first.name
    end
    
    should "get the list of pets available for the given shelter" do
      stub_get("http://api.petfinder.com/shelter.getPets?key=1234567&id=123", "pet_list.xml")
      pets = @client.shelter_pets(123)
      assert_equal 'Petey', pets.first.name      
    end
    
    should "get an authorization token" do
      digest = @client.send(:digest_key_and_secret)
      stub_get("http://api.petfinder.com/auth.getToken?key=1234567&sig=#{digest}", "auth.xml")
      assert_equal '39038a000f404335d90bab019c0c7e2d', @client.token
    end
    
  end

  
end
