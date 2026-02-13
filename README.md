# Simple Weather Forecast App

This is a simple weather forecast app built using Ruby on Rails. Given an address as input, we retrieve the forecast data for the given address with the current temperature and display it to the user.

## High Level Flow

1. Users begin on Forecasts#index page. User enters an address in the search bar and hits search.
2. ForecastsController#search receives the address params and geocodes the address to extract the zip code.
3. With the zip code and address information, attempt to fetch current weather info.
  - If we've already fetched weather info for this zip code in the last 30 minutes, that weather information is returned from cache.
  - If not, will we make a call to WeatherService to fetch the latest weather information.
4. Current weather info gets populated back on the Forecasts#index page without refresh.

## Major Dependencies

- **Geocoder gem**: Parse address parameters and extract zip code and lat/lon coordinates. Depends on Nominatim API.
- **OpenWeatherMap API**: Fetches current weather forecast using lat/lon coordinates.
- **Redis**: High performance caching layer, to minimize refetching from external APIs as much as possible, for both Geocoder and OpenWeatherMap API calls.
- **Hotwire/Turbo**: Lightweight Rails-integrated JS mini-framework for SPA-like page updates without refreshing.

## Design Considerations & Trade-offs

- **Caching**: I chose to go with Redis, an in-memory key-value store, as the caching backend. I considered going with Solid Cache, which uses the DB as the persistence layer of the cache, which is the newer built-in default for modern Rails applications. While Solid Cache/DB-backed cache would make the cache very resilient to data loss, it comes at the cost of performance, even with SSD storage. The hybrid approach I did not get the time to implement would have layered a custom baked DB table as a 2nd layer cache, as a robust, long-lived backup to the Redis cache in case of failure.

## Potential Future Improvements

- Add a forecasts table to the DB to act as a 2nd layer cache.
- Add more unit and integration tests.
- Add deployment setup (Render, AWS, etc.).
- Add continuous integration and continuous delivery, such as via GitHub actions.
