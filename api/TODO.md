# TODO

- [X] Consistent request payload: `{"address": string}`
- [X] Consistent response payload: `{"data": {}, "errors": []}`
- [ ] Consistent error payload: `{"message": "", "code": ""}`
- [X] Store geocoded address lat/lng, postalcode, indefinitely
- [X] Store geocode address failures indefinitely *unless* the geocode error was server/rate limit related using [RubyGeocoder](http://www.rubygeocoder.com)
- [X] Setup API versioning
- [X] Checks store for forecast data matching postalcode using [WeatherAPI](https://www.weatherapi.com/my/)
- [X] Lazily remove stored forecast data if the postalcode is requested again and the data is older than 30 minutes
- [X] Fetches forecast data from weather api if not found in store
- [ ] Use ElasticSearch to search `locations`
