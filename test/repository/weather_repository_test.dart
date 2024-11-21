import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:dio/dio.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talker/talker.dart';
import 'package:weather/errors/generic_exception.dart';
import 'package:weather/errors/invalid_api_exception.dart';
import 'package:weather/errors/not_found_exception.dart';
import 'package:weather/models/city/city.dart';
import 'package:weather/models/forecast/forecast.dart';
import 'package:weather/repositories/mappers/city_mapper.dart';
import 'package:weather/repositories/mappers/forecast_mapper.dart';
import 'package:weather/services/network/dtos/city/city_dto.dart';
import 'package:weather/services/network/dtos/clouds/clouds_dto.dart';
import 'package:weather/services/network/dtos/coord/coord_dto.dart';
import 'package:weather/services/network/dtos/forecast/forecast_dto.dart';
import 'package:weather/services/network/dtos/main/main_dto.dart';
import 'package:weather/services/network/dtos/rain/rain_dto.dart';
import 'package:weather/services/network/dtos/snow/snow_dto.dart';
import 'package:weather/services/network/dtos/sys/sys_dto.dart';
import 'package:weather/services/network/dtos/weather/weather_dto.dart';
import 'package:weather/services/network/dtos/wind/wind_dto.dart';
import 'package:weather/services/network/responses/forecast/forecast_response.dart';
import 'package:weather/services/network/rest_client.dart';
import 'package:weather/repositories/weather_repository.dart';

import '../fixtures/models/city_fixture_factory.dart';
import '../fixtures/models/forecast_fixture_factory.dart';
import 'weather_repository_test.mocks.dart';

@GenerateMocks([
  RestClient,
  CityMapper,
  ForecastMapper,
], customMocks: [
  MockSpec<Talker>(unsupportedMembers: {#configure}),
])
void main() {
  late WeatherRepository weatherRepository;

  late MockRestClient restClient;
  late MockTalker logger;
  late MockCityMapper cityMapper;
  late MockForecastMapper forecastMapper;

  late String cityName;
  late ForecastResponse forecastResponse;
  late List<Forecast> forecasts;
  late City city;

  setUp(() {
    restClient = MockRestClient();
    logger = MockTalker();
    cityMapper = MockCityMapper();
    forecastMapper = MockForecastMapper();

    weatherRepository = WeatherRepositoryImpl(
      restClient: restClient,
      logger: logger,
      cityMapper: cityMapper,
      forecastMapper: forecastMapper,
    );

    cityName = faker.address.city();
    forecasts = ForecastFixture.factory().makeMany(3);
    city = CityFixture.factory().makeSingle();
    forecastResponse = ForecastResponse(
      code: '200',
      message: 0,
      city: CityDTO(
        id: city.id,
        name: city.name,
        coord: CoordDTO(
          lat: city.coord.lat,
          lon: city.coord.lon,
        ),
        country: city.country,
        population: city.population,
        timezone: city.timezone,
        sunrise: city.sunrise,
        sunset: city.sunset,
      ),
      forecast: forecasts
          .map(
            (forecast) => ForecastDTO(
              dt: forecast.dt,
              main: MainDTO(
                feelsLike: forecast.main.feelsLike,
                tempMin: forecast.main.tempMin,
                tempMax: forecast.main.tempMax,
                pressure: forecast.main.pressure,
                seaLevel: forecast.main.seaLevel,
                grndLevel: forecast.main.grndLevel,
                humidity: forecast.main.humidity,
                tempKf: forecast.main.tempKf,
                temp: forecast.main.temp,
              ),
              weather: forecast.weather
                  .map((weather) => WeatherDTO(
                        id: weather.id,
                        main: weather.main,
                        description: weather.description,
                        icon: weather.icon,
                      ))
                  .toList(growable: false),
              clouds: forecast.clouds?.let(
                (clouds) => CloudsDTO(clouds.all),
              ),
              wind: forecast.wind?.let(
                (wind) => WindDTO(
                  speed: wind.speed,
                  deg: wind.deg,
                ),
              ),
              rain: forecast.rain?.let(
                (rain) => RainDTO(rain.threeHours),
              ),
              snow: forecast.snow?.let(
                (snow) => SnowDTO(snow.threeHours),
              ),
              visibility: forecast.visibility,
              pop: forecast.pop,
              sys: SysDTO(forecast.sys.pod),
              dtTxt: forecast.dtTxt,
            ),
          )
          .toList(growable: false),
    );
  });

  test('search for a valid city', () async {
    when(restClient.forecast(city: cityName)).thenAnswer(
      (_) async => forecastResponse,
    );
    for (var i = 0; i < forecasts.length; i++) {
      when(forecastMapper.fromForecastDTO(forecastResponse.forecast[i]))
          .thenReturn(forecasts[i]);
    }
    when(cityMapper.fromCityDTO(forecastResponse.city)).thenReturn(city);

    final (actualForecasts, actualCity) =
        await weatherRepository.forecast(cityName);

    expect(actualForecasts, forecasts);
    expect(actualCity, city);

    verify(restClient.forecast(city: cityName)).called(1);
    for (var i = 0; i < forecasts.length; i++) {
      verify(forecastMapper.fromForecastDTO(forecastResponse.forecast[i]))
          .called(1);
    }
    verify(cityMapper.fromCityDTO(forecastResponse.city)).called(1);
  });

  test('search for a city that doesn\'t exist', () async {
    when(restClient.forecast(city: cityName)).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
        ),
      ),
    );

    try {
      await weatherRepository.forecast(cityName);
    } on NotFoundException catch (error) {
      expect(error, isNotNull);
      expect(error.city, cityName);
    }

    verify(restClient.forecast(city: cityName)).called(1);
  });

  test('search with an invalid token', () async {
    when(restClient.forecast(city: cityName)).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
        ),
      ),
    );

    try {
      await weatherRepository.forecast(cityName);
    } on InvalidAPIException catch (error) {
      expect(error, isNotNull);
    }

    verify(restClient.forecast(city: cityName)).called(1);
  });

  test('search with a generic error', () async {
    when(restClient.forecast(city: cityName)).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
      ),
    );

    try {
      await weatherRepository.forecast(cityName);
    } on GenericException catch (error) {
      expect(error, isNotNull);
    }

    verify(restClient.forecast(city: cityName)).called(1);
  });
}
