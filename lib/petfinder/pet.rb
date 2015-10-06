module Petfinder
  class Pet
    extend XmlMapper

    xml_attributes :id, :name, :animal, :mix, :age, :shelter_id, :shelter_pet_id,
      :sex, :size, :description, :last_update, :status, :contact

    attr_reader :photos

    def initialize(xml)
      @xml = xml
    end

    def self.multiple(xml)
      xml.xpath("//pets/pet").map do |node|
        Pet.new(Nokogiri::XML(node.to_xml))
      end
    end

    def description_sanitized
      Nokogiri::HTML(CGI.unescapeHTML(description)).content
    end

    def breeds
      @xml.xpath("//pet/breeds/breed").map(&:text)
    end

    def options
      @xml.xpath("//pet/options/option").map(&:text)
    end

    def city
      @xml.xpath("//pet/contact/city").map(&:text)
    end

    def photos
      parse_photos unless @photos
      @photos
    end

    def inspect
      "#<Pet id: '#{id}', name: '#{name}', animal: '#{animal}', mix: '#{mix}', sex: '#{sex}'>"
    end

    private

    def parse_photos
      @photos = []
      @xml.xpath("//pet/media/photos/photo").each do |node|
        add_photo(node.attr("id"), node.attr("size"), node.text)
      end
    end

    def add_photo(id, size, url)
      photo = @photos.find { |photo| photo.id == id } || Photo.new(id)
      case size
      when "x"
        photo.large = url
      when "pn"
        photo.medium = url
      when "fpm"
        photo.small = url
      when "pnt"
        photo.thumbnail = url
      when "t"
        photo.tiny = url
      end
      @photos << photo unless @photos.include?(photo)
    end

    class Photo
      attr_accessor :id, :large, :medium, :small, :thumbnail, :tiny

      def initialize(id)
        @id = id
      end
    end

  end
end
