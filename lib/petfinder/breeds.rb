module Petfinder
  class Breeds

    def initialize(xml)
      @xml = xml
    end

    def breeds
      @xml.xpath("//breeds/breed").map(&:text)
    end

  end
end
