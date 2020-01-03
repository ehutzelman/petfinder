RSpec.describe Petfinder::Client do

  before do
    stub_post("https://api.petfinder.com/v2/oauth2/token", "token.json")
  end

  let(:client) { Petfinder::Client.new('api_key', 'api_secret') }

  it 'returns array of animals with pagination' do
    stub_get("https://api.petfinder.com/v2/animals", "animals.json")
    animals, pagination = client.animals

    expect(animals.first.name).to eq("Clarissa")
    expect(pagination.current_page).to eq(1)
  end

  it 'returns a specific animal' do
    stub_get("https://api.petfinder.com/v2/animals/123", "animal.json")
    animal = client.animal(123)

    expect(animal.name).to eq("Apollo")
  end

  it 'returns array of animal types' do
    stub_get("https://api.petfinder.com/v2/types", "types.json")
    types = client.types

    expect(types.length).to eq(8)
    expect(types[1].name).to eq("Cat")
  end

  it 'returns a specific animal type' do
    stub_get("https://api.petfinder.com/v2/types/dog", "type.json")
    type = client.type('dog')

    expect(type.name).to eq("Dog")
  end

  it 'returns list of breeds for animal type' do
    stub_get("https://api.petfinder.com/v2/types/bird/breeds", "breeds.json")
    breeds = client.breeds('bird')

    expect(breeds.length).to eq(39)
    expect(breeds.first.name).to eq("African Grey")
  end

  it 'returns array of organizations with pagination' do
    stub_get("https://api.petfinder.com/v2/organizations", "organizations.json")
    organizations, pagination = client.organizations

    expect(organizations.first.name).to eq("Alberta Bulldog Rescue - Red Deer")
    expect(pagination.current_page).to eq(1)
  end

  it 'returns a specific organization' do
    stub_get("https://api.petfinder.com/v2/organizations/mo201", "organization.json")
    organization = client.organization('mo201')

    expect(organization.name).to eq("Animal Shelter Of Linn County")
  end

end
