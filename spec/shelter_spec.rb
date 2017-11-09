require 'spec_helper'

describe Petfinder::Pet do
  before do
    @shelter = Petfinder::Shelter.new(Nokogiri::XML(fixture_file('shelter.xml')))
  end

  it "should populate attributes of shelter" do
    [:id, :name, :address1, :address2, :city, :state, :zip, :country, :latitude, :longitude, :phone, :fax, :email].each do |attr|
      @shelter.send(attr).should_not == ""
    end
  end

  it "should populate multiple shelter objects" do
    shelters = Petfinder::Shelter.multiple(Nokogiri::XML(fixture_file('shelter_list.xml')))
    shelters.count.should eq(25)
  end

  it "should return a friendly inspect" do
    @shelter.inspect.should eq("#<Shelter id: 'TX1356', name: 'Lucky Dog Rescue', state: 'TX'>")
  end
end

