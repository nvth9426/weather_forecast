require 'rails_helper'

RSpec.describe Address, type: :model do
  it "is valid with street_address, city, state, and zip code" do
    address = Address.new(
      street_address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip_code: Faker::Address.zip_code
    )
    expect(address).to be_valid
  end

  context "get coordinates and extended forecast" do
    let(:address) { Address.create(street_address: "1600 Pennsylvania Ave", city: "Washington", state: "DC", zip_code: "20500") }

    it "saves coordinates in the database after created" do  
      response = {"result"=> {"addressMatches" =>["coordinates"=>{"x"=>-77.03518753691, "y"=>38.89869893252}]}}
      allow(address).to receive(:save_coordinates).and_return(response)
      expect(address.longitude).to eq("-77.03518753691")
      expect(address.latitude).to eq("38.89869893252")
    end

    it "saves extended forecasts in the Redis server" do
      # TODO
    end
  end  
end