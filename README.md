# README

This monolithic Rails application is used for display extended weather forecast up to 7 days. Using web service from 
https://geocoding.geo.census.gov/geocoder/Geocoding_Services_API.html to get the coordinates (latitude and longitude) of an valid address and from https://api.weather.gov to get the forecast, respectively.

The application needs Postgresql and Redis. The .env file needs to have following variables:

DB_USERNAME=[username for the database]
DB_PASSWORD=[password for the database]
DB_NAME=[name of the database]
DB_HOST=[host of database]
TEST_DB_NAME=[name of test database, for rspec]
NATIIONAL_WEATHER_SERVICE_URI= "https://api.weather.gov"
GEOCODING_SERVICE_URI=https://geocoding.geo.census.gov/geocoder/locations/address
REDIS_SERVER_URL=[Redis server, i.e. redis://localhost:6379/0/cache]
