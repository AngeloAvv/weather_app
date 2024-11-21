import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:weather/errors/generic_exception.dart';
import 'package:weather/errors/invalid_api_exception.dart';
import 'package:weather/errors/not_found_exception.dart';
import 'package:weather/models/city/city.dart';
import 'package:weather/models/forecast/forecast.dart';
import 'package:weather/repositories/mappers/city_mapper.dart';
import 'package:weather/repositories/mappers/forecast_mapper.dart';
import 'package:weather/services/network/rest_client.dart';

/// The weather repository used to retrieve the weather forecast
abstract class WeatherRepository {
  /// The method to retrieve the forecast for a particular city
  Future<(List<Forecast>, City)> forecast(
    String city, {
    int? count,
    String? language,
  });
}

/// The weather repository implementation
class WeatherRepositoryImpl implements WeatherRepository {
  /// The restclient to gather the weather from the network layer
  final RestClient restClient;

  /// The logger service
  final Talker logger;

  /// The city mapper to convert the city DTO to a city model
  final CityMapper cityMapper;

  /// The forecast mapper to convert the forecast DTO to a forecast model
  final ForecastMapper forecastMapper;

  /// The WeatherRepository constructor
  const WeatherRepositoryImpl({
    required this.restClient,
    required this.logger,
    required this.cityMapper,
    required this.forecastMapper,
  });

  /// The method to retrieve the forecast for a particular city
  @override
  Future<(List<Forecast>, City)> forecast(
    String city, {
    int? count,
    String? language,
  }) async {
    try {
      logger.debug('Fetching forecast for city $city');
      final response = await restClient.forecast(
        city: city,
        count: count,
        language: language,
      );

      logger.debug('Fetched forecast for city $city');

      final forecasts =
          response.forecast.map(forecastMapper.fromForecastDTO).toList();
      final mappedCity = cityMapper.fromCityDTO(response.city);

      return (forecasts, mappedCity);
    } on DioException catch (error, stackTrace) {
      switch (error.response?.statusCode) {
        case 404:
          logger.error(
            'Cannot find the current forecast for city $city',
            error,
            stackTrace,
          );
          throw NotFoundException(city);
        case 401:
          logger.error('Invalid API token', error, stackTrace);
          throw InvalidAPIException();
        default:
          logger.error('Generic error', error, stackTrace);
          throw GenericException();
      }
    }
  }
}
