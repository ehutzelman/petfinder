module Petfinder
  class Auth

    def initialize(xml)
      @xml = xml
    end

    def key
      @xml.xpath("//auth/key").text
    end

    def token
      @xml.xpath("//auth/token").text
    end

    def expires
      @xml.xpath("//auth/expires").text
    end

    def expires_string
      @xml.xpath("//auth/expiresString").text
    end

  end
end
