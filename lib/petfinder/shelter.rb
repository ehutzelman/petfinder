module Petfinder
  class Shelter
    extend XmlMapper

    xml_attributes :id, :name, :address1, :address2, :city, :state, :zip, :country,
      :latitude, :longitude, :phone, :fax, :email

    def initialize(xml)
      @xml = xml
    end

    def self.multiple(xml)
      xml.xpath("//shelters/shelter").map do |node|
        Shelter.new(Nokogiri::XML(node.to_xml))
      end
    end

  end
end
