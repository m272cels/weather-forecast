class ForecastsController < ApplicationController
  def index
  end

  def search
    @address = params["query"]
    geocoded_location = ::Geocoder.search(@address).first
    @zip = geocoded_location.postal_code

    @from_cache = true
    @current_weather = Rails.cache.fetch("weather_service:#{@zip}", expires_in: 30.minutes) do
      @from_cache = false
      WeatherService.new(@address).get_current_weather
    end
  end
end
