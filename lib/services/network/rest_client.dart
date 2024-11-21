import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather/services/network/responses/forecast/forecast_response.dart';

part 'rest_client.g.dart';

/// The Rest Client API service to gather forecast information
@RestApi(baseUrl: '${RestClient.baseUrl}/data/${RestClient.version}/')
abstract class RestClient {
  /// The API baseUrl
  static const String baseUrl = 'http://api.openweathermap.org';

  /// The API version
  static const String version = '2.5';

  /// The API key
  static const String apiKey = ''; //TODO get your own API key

  /// Helper factory to generate the RestClient constructor
  factory RestClient(Dio dio) => _RestClient(dio);

  @GET('/forecast')

  /// The method to gather forecast information from the API servers
  Future<ForecastResponse> forecast({
    @Query('q') required String city,
    @Query('appid') String apiKey = RestClient.apiKey,
    @Query('mode') String mode = 'json',
    @Query('cnt') int? count,
    @Query('units') String units = 'metric',
    @Query('lang') String? language,
  });
}
