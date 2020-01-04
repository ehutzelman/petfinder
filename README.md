# Petfinder

[![Gem Version](https://badge.fury.io/rb/petfinder.png)][gem]
[![Build Status](https://secure.travis-ci.org/ehutzelman/petfinder.png?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/ehutzelman/petfinder.png)](https://codeclimate.com/github/ehutzelman/petfinder)

[gem]: https://rubygems.org/gems/petfinder
[travis]: http://travis-ci.org/ehutzelman/petfinder

Ruby gem wrapper for the [Petfinder API v2.0](https://www.petfinder.com/developers/v2/docs).

**NOTE**: The gem to support v1.0 of the API can be found on the [v1 branch](https://github.com/ehutzelman/petfinder/tree/v1), but be warned that
Petfinder will be deprecating this v1 API in early 2020.

## Installation

Add this line to your application's Gemfile:

    gem 'petfinder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install petfinder

## Get your API key

Get your Petfinder API key at: https://www.petfinder.com/developers

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

#### Return a list of dogs in the "90210" zip code (with pagination)
A hash of parameters can be passed to this method, but none are required. You can find the full set of allowable parameters here:
[Petfinder animals endpoint documentation](https://www.petfinder.com/developers/v2/docs/#get-animals).

```ruby
animals, pagination = petfinder.animals(type: 'dog', location: '90210', page: 1)

animals.first.name
# => "Tyra"
animals.first.photos.first.full
# => "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/47027518/2/?bust=1578168103"
animals.first.organization_id
# => "CA2350"

animals.pagination.count_per_page
# => "20"
animals.pagination.total_pages
# => "8853"
```

#### Return a list of organizations (with pagination)
A hash of parameters can be passed to this method, but none are required. You can find the full set of allowable parameters here:
[Petfinder organizations endpoint documentation](https://www.petfinder.com/developers/v2/docs/#get-organizations).

```ruby
organizations, pagination = petfinder.organizations({ location: '90210', limit: 5 })

organizations.first.name
# => "STAR Eco Station"

organizations.pagination.count_per_page
# => "5"
organizations.pagination.total_count
# => "265"
organizations.pagination.total_pages
# => "53"
```

#### Return information about the organization (shelter) with id "CA2350"

```ruby
organization = petfinder.organization('CA2350')

organization.name
# => "Promise 4 Paws"

organization.address.city
# => "San Juan Capistrano"
```

#### Return a list of animal types
```ruby
types = petfinder.types

types.first.name
# => "Dog"

types.first.colors
# => ["Brown", "Black", "Yellow"]
```

#### Return a list of breeds for a given animal type
```ruby
breeds = petfinder.breeds('dog')

breeds.length
# => 275

breeds.first.name
# => "Affenpinscher"
```

## Handling errors
A Petfinder::Error exception will be raised if the response fails with a bad response. This exception contains a hash of error information returned by Petfinder.

```ruby
animals, pagination = petfinder.animals(type: 'invalid_type')
# => Petfinder::Error (Invalid Request: The request contains invalid parameters.)

rescue Petfinder::Error => exception

exception.data
# => {"type"=>"https://www.petfinder.com/developers/v2/docs/errors/ERR-00002/", "status"=>400, "title"=>"Invalid Request", "detail"=>"The request contains invalid parameters.", "invalid-params"=>[{"in"=>"query", "path"=>"type", "message"=>"invalid_type is not a valid animal type."}]}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2010-2020 Eric Hutzelman.
See [LICENSE][] for details.

[license]: LICENSE.txt
