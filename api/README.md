# README

## Description

A simple API service that lazily geocodes input addresses (or zipcodes) using [RubyGeocoder](http://www.rubygeocoder.com).

Stored geocoded addresses are used to lazily refresh the 10-day forecast using [WeatherAPI](https://www.weatherapi.com).

All successful forecast responses are cached up to 30 minutes. During the initial 30 minute cache any subsequent address lookups that resolve to the same same `postal_code` will return the cached response. After 30 minutes the cache is lazily refreshed when the `postal_code` is requested again.

All responses are JSON and follow the following format:

```json
{
  "data": {},
  "errors": []
}
```

## Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Get Started (Locally)

1. Clone this repo

```bash
git clone git@github.com:temp-check/api.git
```

2. You'll need to setup a [WeatherAPI](https://www.weatherapi.com/my/) account and get an API key. Once you have your API key, copy the example `.example-env` file to `.env`

```bash
cp .example-env .env
```

and update `WEATHER_API_KEY` value with your API key.

3. Bundle the gems

```bash
bundle install
```

4. Create & migrate the development database

```bash
rails db:create db:migrate
```

5. Start the app
  
```bash
rails s
```

6. The app should now be running at http://localhost:3000

## Endpoints

### GET /api/v1/address

#### Query Parameters

| Name | Type | Description |
| --- | --- | --- |
| q | string | The address or zipcode to geocode & return a 10-day forecast for |

#### Example Request

```bash

curl -X GET \
  'http://localhost:3000/api/v1/address?q=cupertino,ca' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json'
```

#### Example Response

```json
{"data":{"id":"09eb1a68-8708-40f7-a3de-4e397257cd09","address":"cupertino,ca","postal_code_id":"cea2a725-8d07-4a3a-a841-74a9caa3d548","lat":"37.322893","lng":"-122.03229","geocode_error":null,"created_at":"2023-11-28T18:56:23.010Z","updated_at":"2023-11-28T18:56:23.010Z","postal_code":{"id":"cea2a725-8d07-4a3a-a841-74a9caa3d548","code":"95014","created_at":"2023-11-28T16:36:26.924Z","updated_at":"2023-11-28T16:36:26.924Z","temperature":{"id":"a4b53d6f-0e09-4323-92e5-52f1ab595e0f","forecast":[{"date":"2023-11-28","max_f":66.4,"min_f":44.6,"max_c":19.1,"min_c":7.0,"icon":"https://cdn.weatherapi.com/weather/64x64/day/113.png"},{"date":"2023-11-29","max_f":61.5,"min_f":46.8,"max_c":16.4,"min_c":8.2,"icon":"https://cdn.weatherapi.com/weather/64x64/day/176.png"},{"date":"2023-11-30","max_f":60.1,"min_f":43.7,"max_c":15.6,"min_c":6.5,"icon":"https://cdn.weatherapi.com/weather/64x64/day/119.png"},{"date":"2023-12-01","max_f":59.2,"min_f":45.7,"max_c":15.1,"min_c":7.6,"icon":"https://cdn.weatherapi.com/weather/64x64/day/113.png"},{"date":"2023-12-02","max_f":60.1,"min_f":46.7,"max_c":15.6,"min_c":8.2,"icon":"https://cdn.weatherapi.com/weather/64x64/day/116.png"},{"date":"2023-12-03","max_f":63.0,"min_f":47.0,"max_c":17.2,"min_c":8.3,"icon":"https://cdn.weatherapi.com/weather/64x64/day/116.png"},{"date":"2023-12-04","max_f":65.2,"min_f":50.4,"max_c":18.5,"min_c":10.2,"icon":"https://cdn.weatherapi.com/weather/64x64/day/113.png"},{"date":"2023-12-05","max_f":67.4,"min_f":50.7,"max_c":19.7,"min_c":10.4,"icon":"https://cdn.weatherapi.com/weather/64x64/day/122.png"},{"date":"2023-12-06","max_f":66.5,"min_f":51.3,"max_c":19.2,"min_c":10.7,"icon":"https://cdn.weatherapi.com/weather/64x64/day/113.png"},{"date":"2023-12-07","max_f":66.9,"min_f":48.9,"max_c":19.4,"min_c":9.4,"icon":"https://cdn.weatherapi.com/weather/64x64/day/113.png"}],"postal_code_id":"cea2a725-8d07-4a3a-a841-74a9caa3d548","cached":true,"created_at":"2023-11-28T16:36:26.937Z","updated_at":"2023-11-28T16:36:27.910Z"}}},"errors":[]}
```
