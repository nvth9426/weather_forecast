class Address < ApplicationRecord
  validates :street_address, :city, :state, :zip_code, presence: true
  after_create :save_coordinates

  def save_forecasts
    forecast_data = ForecastService.get_forecast(latitude, longitude)
    Rails.cache.write(zip_code, forecast_data, expires_in: 30.minutes)
  end

  private

  def save_coordinates
    # get coordinates from National Geocoding Services
    longitude, latitude = AddressService.get_coordinates(id)
    update(longitude: longitude, latitude: latitude)
  end
end
