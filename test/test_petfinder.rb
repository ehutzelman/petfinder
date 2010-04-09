require 'helper'

class TestPetfinder < Test::Unit::TestCase

  context "When working with the Petfinder API" do
    setup do
      @client = Petfinder::Client.new('8675309')
    end

    should "get a random pet" do
      stub_get("http://api.petfinder.com/pet.getRandom?key=8675309&output=full", "pet_full.xml")
      pet = @client.random_pet
      assert_equal 'Charlie', pet.name
    end
    
    should "get the list of breeds for the given animal type" do
      stub_get("http://api.petfinder.com/breed.list?key=8675309&animal=horse", "breeds.xml")
      breeds = @client.breeds('horse')
      assert_equal 'Appaloosa', breeds.first
    end
  end
  
end
