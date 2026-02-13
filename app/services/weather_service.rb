# frozen_string_literal: true

class WeatherService
  attr_reader :address, :geocoded_location

  def initialize(address)
    @address = address
    @geocoded_location = Geocoder.search(address).first
  end

  def get_current_weather
    open_weather_get_current!
  end

  private

  def open_weather_get_current!
    lat, lon = geocoded_location.coordinates
    conn = Faraday.new("https://api.openweathermap.org") do |f|
      f.request :json # encode req bodies as JSON and automatically set the Content-Type header
      f.request :retry # retry transient failures
      f.response :json # decode response bodies as JSON
    end
    response = conn.get("/data/2.5/weather", {
      appid: Rails.application.credentials.openweather_api_key,
      lat:,
      lon:,
      units: "imperial"
    })
    body = response.body
    body.dig("main", "temp")
  end
end
