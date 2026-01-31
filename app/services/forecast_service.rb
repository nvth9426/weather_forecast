class ForecastService 

  def self.get_forecast(latitude, longitude)
    begin
      # first get the forecast endpoint from National Weather Service
      forecast_uri = get_forecast_uri(latitude, longitude)
      response = HTTParty.get "#{forecast_uri}"
      data = JSON.parse(response)
      data['properties']['periods']
    rescue
      nil
    end  
  end

  def self.get_forecast_uri(latitude, longitude)
    response = HTTParty.get "#{ENV['NATIIONAL_WEATHER_SERVICE_URI']}/points/#{latitude},#{longitude}"
    data = JSON.parse(response)
    data['properties']["forecast"]
  end
end