module Petfinder
  class Auth
    extend XmlMapper

    xml_attributes :key, :token, :expires, :expires_string

    def initialize(xml)
      @xml = xml
    end

  end
end
