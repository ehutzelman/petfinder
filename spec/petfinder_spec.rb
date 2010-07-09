require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Petfinder::Client do
  before do
    @client = Petfinder::Client.new('1234567', 'mysekrit')
  end

  it "should get a random pet" do
    stub_get("http://api.petfinder.com/pet.getRandom?key=1234567&output=full", "pet.xml")
    pet = @client.random_pet
    pet.name.should == 'Charlie'
  end
  
  it "should get a specific pet by id" do
    stub_get("http://api.petfinder.com/pet.get?key=1234567&id=123", "pet.xml")
    pet = @client.pet(123)
    pet.name.should == 'Charlie'
  end
  
  it "should find pets matching a query" do
    stub_get("http://api.petfinder.com/pet.find?key=1234567&animal=dog&location=77007", "pet_list.xml")
    pets = @client.find_pets('dog', '77007')
    pets.first.name.should == 'Petey'    
  end
  
  describe "retrieving a pet" do
    before do
      stub_get("http://api.petfinder.com/pet.getRandom?key=1234567&output=full", "pet.xml")
      @pet = @client.random_pet      
    end
    
    it "should hide photos collection" do
      @pet.should_not respond_to(:photos)
    end
    
    it "should reorganize photos for pet as pictures" do
      @pet.pictures[0].thumbnail.should == 'http://photocache.petfinder.com/fotos/IL173/IL173.10141994-1-pnt.jpg'
      @pet.pictures[1].large.should == 'http://photocache.petfinder.com/fotos/IL173/IL173.10141994-2-x.jpg'
    end
  end
  
  it "should get the list of breeds for the given animal type" do
    stub_get("http://api.petfinder.com/breed.list?key=1234567&animal=horse", "breed_list.xml")
    breeds = @client.breeds('horse')
    breeds.first.should == "Appaloosa"
  end

  it "should get a specific shelter by id" do
    stub_get("http://api.petfinder.com/shelter.get?key=1234567&id=123", "shelter.xml")
    shelter = @client.shelter(123)
    shelter.name.should == 'Lucky Dog Rescue'
  end

  it "should find shelters matching a query" do
    stub_get("http://api.petfinder.com/shelter.find?key=1234567&location=77007", "shelter_list.xml")
    shelters = @client.find_shelters('77007')
    shelters.first.name.should == 'Pup Squad Animal Rescue'
  end

  it "should find shelters matching a breed" do
    stub_get("http://api.petfinder.com/shelter.listByBreed?key=1234567&animal=horse&breed=arabian", "shelter_list.xml")
    shelters = @client.find_shelters_by_breed('horse', 'arabian')
    shelters.first.name.should == 'Pup Squad Animal Rescue'
  end
  
  it "should get the list of pets available for the given shelter" do
    stub_get("http://api.petfinder.com/shelter.getPets?key=1234567&id=123", "pet_list.xml")
    pets = @client.shelter_pets(123)
    pets.first.name.should == 'Petey'    
  end
  
  it "should get an authorization token" do
    digest = @client.send(:digest_key_and_secret)
    stub_get("http://api.petfinder.com/auth.getToken?key=1234567&sig=#{digest}", "auth.xml")
    @client.token.should == '39038a000f404335d90bab019c0c7e2d'
  end
  
end