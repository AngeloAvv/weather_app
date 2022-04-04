import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/models/city.dart';
import 'package:weather/models/coord.dart';
import 'package:weather/models/forecast.dart';
import 'package:weather/models/main.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/network/dtos/response_forecast.dart';
import 'package:weather/network/rest_client.dart';

void main() {
  RestClient? restClient;

  setUp(() {
    Dio dio = Dio();
    restClient = RestClient(dio);
  });

  void _testCoord(Coord? coord) {
    expect(coord?.lat, isNotNull);
    expect(coord?.lat, isNotNaN);
    expect(coord?.lat, isPositive);

    expect(coord?.lon, isNotNull);
    expect(coord?.lon, isNotNaN);
    expect(coord?.lon, isPositive);
  }

  void _testCity(City? city) {
    expect(city?.id, isNotNull);
    expect(city?.id, isNotNaN);
    expect(city?.id, isPositive);

    expect(city?.name, isNotNull);
    expect(city?.name, isNotEmpty);

    expect(city?.coord, isNotNull);

    expect(city?.country, isNotNull);
    expect(city?.country, isNotEmpty);

    expect(city?.population, isNotNull);
    expect(city?.population, isNotNaN);

    expect(city?.timezone, isNotNull);
    expect(city?.timezone, isNotNaN);

    expect(city?.sunrise, isNotNull);
    expect(city?.sunrise, isNotNaN);

    expect(city?.sunset, isNotNull);
    expect(city?.sunset, isNotNaN);

    _testCoord(city?.coord);
  }

  void _testMain(Main main) {
    expect(main.temp, isNotNull);
    expect(main.temp, isNotNaN);

    expect(main.feelsLike, isNotNull);
    expect(main.feelsLike, isNotNaN);

    expect(main.tempMin, isNotNull);
    expect(main.tempMin, isNotNaN);

    expect(main.tempMax, isNotNull);
    expect(main.tempMax, isNotNaN);

    expect(main.pressure, isNotNull);
    expect(main.pressure, isNotNaN);

    expect(main.seaLevel, isNotNull);
    expect(main.seaLevel, isNotNaN);

    expect(main.grndLevel, isNotNull);
    expect(main.grndLevel, isNotNaN);

    expect(main.humidity, isNotNull);
    expect(main.humidity, isNotNaN);
    expect(main.humidity, isPositive);

    expect(main.tempKf, isNotNull);
    expect(main.tempKf, isNotNaN);
  }

  void _testWeather(Weather weather) {
    expect(weather.id, isNotNull);
    expect(weather.id, isNotNaN);
    expect(weather.id, isPositive);

    expect(weather.main, isNotNull);
    expect(weather.main, isNotEmpty);

    expect(weather.description, isNotNull);
    expect(weather.description, isNotEmpty);

    expect(weather.icon, isNotNull);
    expect(weather.icon, isNotEmpty);
  }

  void _testForecast(Forecast forecast) {
    expect(forecast.dt, isNotNull);

    expect(forecast.main, isNotNull);
    _testMain(forecast.main);

    expect(forecast.weather, isNotNull);
    expect(forecast.weather, isNotEmpty);

    expect(forecast.visibility, isNotNull);
    expect(forecast.visibility, isNotNaN);
    expect(forecast.visibility, isNonNegative);

    expect(forecast.pop, isNotNull);
    expect(forecast.pop, isNotNaN);
    expect(forecast.pop, isNonNegative);

    expect(forecast.sys, isNotNull);

    expect(forecast.dtTxt, isNotNull);
    expect(forecast.dtTxt, isNotEmpty);

    forecast.weather.forEach(_testWeather);
  }

  test('search for a city that does exist', () async {
    final result = await restClient?.forecast(city: 'bari');

    expect(result, isNotNull);

    expect(result?.code, isNotNull);
    expect(result?.code, isNotEmpty);

    expect(result?.message, isNotNull);
    expect(result?.message, isNotNaN);

    expect(result?.city, isNotNull);

    expect(result?.forecast, isNotNull);
    expect(result?.forecast, isNotEmpty);

    _testCity(result?.city);

    result?.forecast.forEach(_testForecast);
  });

  test('search for a city that doesn\'t exist', () async {
    ResponseForecast? result;
    try {
      result = await restClient?.forecast(city: 'blablabla');
    } on DioError catch (error) {
      expect(error, isNotNull);
      expect(error.response?.statusCode, 404);
    }

    expect(result, isNull);
  });

  test('search with a wrong API key', () async {
    ResponseForecast? result;
    try {
      result = await restClient?.forecast(
        city: 'bari',
        apiKey: 'blablabla',
      );
    } on DioError catch (error) {
      expect(error, isNotNull);
      expect(error.response?.statusCode, 401);
    }

    expect(result, isNull);
  });
}
