import 'package:dio/dio.dart';
import 'package:weather/errors/generic_exception.dart';
import 'package:weather/errors/invalid_api_exception.dart';
import 'package:weather/errors/not_found_exception.dart';
import 'package:weather/network/dtos/response_forecast.dart';
import 'package:weather/network/rest_client.dart';

/// The weather repository used to retrieve the weather forecast
class WeatherRepository {
  /// The restclient to gather the weather from the network layer
  final RestClient restClient;

  /// The WeatherRepository constructor
  WeatherRepository({required this.restClient});

  /// The method to retrieve the forecast for a particular city
  Future<ResponseForecast> forecast({
    required String city,
    int? count,
    String? language,
  }) async {
    ResponseForecast? response;

    try {
      response = await restClient.forecast(
        city: city,
        count: count,
        language: language,
      );
    } on DioError catch (error) {
      switch (error.response?.statusCode) {
        case 404:
          throw NotFoundException(city);
        case 401:
          throw InvalidAPIException();
        default:
          throw GenericException();
      }
    }

    return response;
  }
}
