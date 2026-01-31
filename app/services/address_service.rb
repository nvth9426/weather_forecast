class AddressService
  def self.get_coordinates(address_id)
    begin
      address = Address.find(address_id)
      url_encoded_address = get_address_encoded_url(address)
      response = HTTParty.get "#{ENV['GEOCODING_SERVICE_URI']}?#{url_encoded_address}&benchmark=4&format=json"
     
      if response['result']['addressMatches'].blank?
        return
      else  
        coordinates = response['result']['addressMatches'].first["coordinates"]
        [coordinates['x'], coordinates['y']]
      end
    rescue
      nil
    end
  end

  def self.get_address_encoded_url(address)
    "street=#{address.street_address.gsub(' ','+')}&city=#{address.city.gsub(' ','+')}&state=#{address.state.gsub(' ','+')}&zip=#{address.zip_code}"
  end
end