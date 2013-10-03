# Petfinder

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

    Petfinder.configure do |config|
      config.api_key = 'your_api_key'
      config.api_secret = 'your_api_secret'
    end
    petfinder = Petfinder::Client.new

## Examples

#### Return a list of dogs in the "90210" zip code

    pets = petfinder.find_pets('dog', '90210')
    pets.count
    # => "25"

    pets.first.name
    # => "Petey"

    pets.first.shelterid
    # => "CA123"

#### Return information about the shelter with id "CA123"

    shelter = petfinder.shelter('CA123')
    shelter.name
    # => "Melrose Place SPCA"

## TODO

* Implement use of security token when Petfinder requires it
* Support paging for results

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
