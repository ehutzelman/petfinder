# Petfinder

[![Gem Version](https://badge.fury.io/rb/petfinder.png)][gem]
[![Build Status](https://secure.travis-ci.org/ehutzelman/petfinder.png?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/ehutzelman/petfinder.png)](https://codeclimate.com/github/ehutzelman/petfinder)

[gem]: https://rubygems.org/gems/petfinder
[travis]: http://travis-ci.org/ehutzelman/petfinder

Ruby gem wrapper for the [Petfinder API](http://www.petfinder.com/developers/api-docs).

## Installation

Add this line to your application's Gemfile:

    gem 'petfinder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install petfinder

## Get your API key

Get your Petfinder API key at: http://www.petfinder.com/developers/api-key

## Usage

### Instantiate a client

    petfinder = Petfinder::Client.new('your_api_key', 'your_api_secret')

### or configure once

```ruby
Petfinder.configure do |config|
  config.api_key = 'your_api_key'
  config.api_secret = 'your_api_secret'
end
petfinder = Petfinder::Client.new
```

## Examples

#### Return a list of dogs in the "90210" zip code

```ruby
pets = petfinder.find_pets('dog', '90210')
pets.count
# => "25"

pets.first.name
# => "Petey"

pets.first.shelterid
# => "CA123"
```

#### Return information about the shelter with id "CA123"

```ruby
shelter = petfinder.shelter('CA123')
shelter.name
# => "Melrose Place SPCA"
```

#### Other available methods

```ruby
# Valid animal types: barnyard, bird, cat, dog, horse, pig, reptile, smallfurry
breeds = petfinder.breeds(animal_type)

# Options available: animal, breed, size, sex, location, shelterid
pet = petfinder.random_pet(options)
pet = petfinder.pet(id)

# Options available: breed, size, sex, age, offset, count
pets = petfinder.find_pets(animal_type, location, options)

# Options available: status, offset, count
pets = shelter_pets(shelter_id, options)
    
# Options available: name, offset, count
shelters = petfinder.find_shelters(location, options)
shelters = petfinder.find_shelters_by_breed(animal_type, breed)

shelter = petfinder.shelter(shelter_id)
```

## TODO

* Implement use of security token when Petfinder requires it
* Support paging for results

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2010-2013 Eric Hutzelman.
See [LICENSE][] for details.

[license]: LICENSE.txt
