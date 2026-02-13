class ForecastsController < ApplicationController
  def index
  end

  def show
    @address = params["address"]
    @zip = params["zip"]

    @temperature = WeatherService.new(@address).get_current_weather
  end

  def search
    address = params["query"]
    geocoded_location = ::Geocoder.search(address).first
    redirect_to action: :show, zip: geocoded_location.postal_code, address:
  end
end
