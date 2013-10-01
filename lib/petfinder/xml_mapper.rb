module Petfinder
  module XmlMapper

    def xml_attributes(*names)
      names.each { |name| xml_attribute(name) }
    end

    def xml_attribute(name, xml_name = nil)
      klass = self.name.split('::').last.downcase
      xml_name ||= camel_case_lower(name.to_s)
      define_method(name) do
        @xml.xpath("//#{klass}/#{xml_name}").text
      end
    end

    def camel_case_lower(name)
      name.split('_').inject([]) { |buffer, e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
    end

  end
end
