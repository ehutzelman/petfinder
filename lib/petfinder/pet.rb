module Petfinder
  
  class Photo
    include HappyMapper

    tag 'photo'
    attribute :id, String
    attribute :size, String
    element :url, String, :tag => '.'
  end

  class Pet
    include HappyMapper
    attr_accessor :pictures
    
    tag 'pet'
    element :id, Integer
    element :shelter_id, String, :tag => 'shelterId'
    element :shelter_pet_id, String, :tag => 'shelterPetId'
    element :name, String
    element :animal, String
    has_many :breeds, String, :tag => 'breed', :deep => true
    element :mix, String
    element :age, String
    element :sex, String
    element :size, String
    has_many :options, String, :tag => 'option', :deep => true
    element :description, String
    element :last_update, DateTime, :tag => 'lastUpdate'
    element :status, String
    has_many :photos, Photo, :tag => 'photo', :deep => true

    private :photos

    after_parse do |pet|
      pet.remove_link_from_description
      pet.consolidate_photos
    end
    
    def remove_link_from_description
      self.description = description[0..description.index("\n") - 1] if description.index("\n")
    end
    
    def consolidate_photos
      @pictures = []
      photos.map {|photo| photo.id}.uniq.each do |id|
        @pictures << Picture.new(photos.select {|photo| photo.id == id})
      end
    end
  end

  class Picture
    attr_reader :large, :medium, :small, :thumbnail, :tiny
  
    def initialize(photos)
      photos.each do |photo|
        case photo.size
        when "x"
          @large = photo.url
        when "pn"
          @medium = photo.url
        when "fpm"
          @small = photo.url
        when "pnt"
          @thumbnail = photo.url
        when "t"
          @tiny = photo.url
        end
      end
    end
  
    def to_s
      large
    end    
  end

end
