import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/errors/generic_exception.dart';
import 'package:weather/errors/not_found_exception.dart';
import 'package:weather/network/dtos/response_forecast.dart';
import 'package:weather/network/rest_client.dart';
import 'package:weather/repositories/weather_repository.dart';

import 'weather_repository_test.mocks.dart';

@GenerateMocks([
  RestClient,
])
void main() {
  WeatherRepository? weatherRepository;

  setUp(() {
    weatherRepository = WeatherRepository(restClient: MockRestClient());
  });

  test('search for a city that doesn\'t exist', () async {
    const city = 'blablabla';

    when(weatherRepository?.forecast(city: city)).thenThrow(
      DioError(
        requestOptions: RequestOptions(
          path: '',
        ),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
        ),
      ),
    );

    ResponseForecast? result;
    try {
      result = await weatherRepository?.forecast(city: city);
    } on NotFoundException catch (error) {
      expect(error, isNotNull);
      expect(error.city, city);
    }

    expect(result, isNull);
  });

  test('search with an empty string', () async {
    when(weatherRepository?.forecast(city: '')).thenThrow(
      DioError(
        requestOptions: RequestOptions(
          path: '',
        ),
        response: Response(
          requestOptions: RequestOptions(path: ''),
        ),
      ),
    );

    ResponseForecast? result;
    try {
      result = await weatherRepository?.forecast(
        city: '',
      );
    } on GenericException catch (error) {
      expect(error, isNotNull);
    }

    expect(result, isNull);
  });
}
