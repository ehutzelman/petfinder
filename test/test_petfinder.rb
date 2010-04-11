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

    should "get an authorization token" do
      digest = @client.send(:digest_key_and_secret)
      stub_get("http://api.petfinder.com/auth.getToken?key=1234567&sig=#{digest}", "auth.xml")
      assert_equal '39038a000f404335d90bab019c0c7e2d', @client.token
    end
    
  end

  
end
