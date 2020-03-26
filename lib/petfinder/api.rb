module Petfinder
  module Api

    def animals(params = {})
      response = request('animals', params)

      animals = response['animals'].map { |animal| Mash.new(animal) }
      pagination = Mash.new(response['pagination'])

      [animals, pagination]
    end

    def animal(id)
      Mash.new(request("animals/#{id}")['animal'])
    end

    def types
      request("types")['types'].map { |type| Mash.new(type) }
    end

    def type(type)
      Mash.new(request("types/#{type}")['type'])
    end

    def breeds(type)
      request("types/#{type}/breeds")['breeds'].map { |breed| Mash.new(breed) }
    end

    def organizations(params = {})
      response = request('organizations', params)

      organizations = response['organizations'].map { |org| Mash.new(org) }
      pagination = Mash.new(response['pagination'])

      [organizations, pagination]
    end

    def organization(id)
      Mash.new(request("organizations/#{id}")['organization'])
    end

  end
end
