json.extract! address, :id, :street_address, :city, :state, :zip_code, :latitude, :longitude, :created_at, :updated_at
json.url address_url(address, format: :json)
