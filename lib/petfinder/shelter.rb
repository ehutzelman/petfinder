module Petfinder
  
  class Shelter
    include HappyMapper

    tag 'shelter'
    element :id, String
    element :name, String
    element :address1, String
    element :address2, String
    element :city, String
    element :state, String
    element :zip, String
    element :country, String
    element :latitude, String
    element :longitude, String
    element :phone, String
    element :fax, String
    element :email, String    
  end

end
