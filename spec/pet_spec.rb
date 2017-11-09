require 'spec_helper'

describe Petfinder::Pet do
  before do
    @pet = Petfinder::Pet.new(Nokogiri::XML(fixture_file('pet.xml')))
  end

  it "should populate collection of photos" do
    [:large, :medium, :small, :thumbnail, :tiny].each do |size|
      @pet.photos[0].send(size).should =~ /http:\/\/photocache.petfinder.com\/fotos\/IL173\/*./
    end
  end

  it "should populate attributes of pet" do
    [:id, :name, :animal, :mix, :age, :shelter_id, :shelter_pet_id, :sex, :size, :description, :last_update, :status].each do |attr|
      @pet.send(attr).should_not == ""
    end
  end

  it "should populate array of breeds" do
    @pet.breeds.should include("Domestic Short Hair-black")

  end

  it "should populate array of options" do
    @pet.options.should include("hasShots", "altered")
  end

  it "should return a sanitized version of the description" do
    @pet.description_sanitized.should_not =~ /<div>/
  end

  it "should populate multiple pet objects" do
    pets = Petfinder::Pet.multiple(Nokogiri::XML(fixture_file('pet_list.xml')))
    pets.count.should eq(25)
  end

  it "should return a friendly inspect" do
    @pet.inspect.should eq("#<Pet id: '10141994', name: 'Charlie', animal: 'Cat', mix: 'no', sex: 'M'>")
  end
end
