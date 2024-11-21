import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/blocs/forecast/forecast_bloc.dart';
import 'package:weather/errors/generic_exception.dart';
import 'package:weather/errors/invalid_api_exception.dart';
import 'package:weather/errors/not_found_exception.dart';
import 'package:weather/models/city/city.dart';
import 'package:weather/models/forecast/forecast.dart';
import 'package:weather/repositories/weather_repository.dart';

import '../fixtures/models/city_fixture_factory.dart';
import '../fixtures/models/forecast_fixture_factory.dart';
import 'forecast_bloc_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late WeatherRepository weatherRepository;
  late ForecastBloc bloc;

  late String cityName;
  late List<Forecast> forecasts;
  late City city;

  setUp(() {
    weatherRepository = MockWeatherRepository();
    bloc = ForecastBloc(
      repository: weatherRepository,
    );

    cityName = faker.address.city();
    forecasts = ForecastFixture.factory().makeMany(3);
    city = CityFixture.factory().makeSingle();
  });

  blocTest<ForecastBloc, ForecastState>(
    'test search with success',
    setUp: () {
      when(weatherRepository.forecast(cityName)).thenAnswer(
        (_) async => (
          forecasts,
          city,
        ),
      );
    },
    build: () => bloc,
    act: (bloc) => bloc.performSearch(cityName),
    expect: () => [
      const FetchingForecastState(),
      FetchedForecastState(
        forecasts: forecasts,
        city: city,
      ),
    ],
  );

  blocTest<ForecastBloc, ForecastState>(
    'test search with an unknown city',
    setUp: () {
      when(weatherRepository.forecast(cityName))
          .thenThrow(NotFoundException(cityName));
    },
    build: () => bloc,
    act: (bloc) => bloc.performSearch(cityName),
    expect: () => [
      const FetchingForecastState(),
      ErrorFetchingForecastState(NotFoundException(cityName))
    ],
    verify: (_) {
      verify(weatherRepository.forecast(cityName)).called(1);
    },
  );

  blocTest<ForecastBloc, ForecastState>(
    'test search with an invalid api',
    setUp: () {
      when(weatherRepository.forecast(cityName))
          .thenThrow(InvalidAPIException());
    },
    build: () => bloc,
    act: (bloc) => bloc.performSearch(cityName),
    expect: () => [
      const FetchingForecastState(),
      ErrorFetchingForecastState(InvalidAPIException())
    ],
    verify: (_) {
      verify(weatherRepository.forecast(cityName)).called(1);
    },
  );

  blocTest<ForecastBloc, ForecastState>(
    'test search with a generic error',
    setUp: () {
      when(weatherRepository.forecast(cityName))
          .thenThrow(GenericException());
    },
    build: () => bloc,
    act: (bloc) => bloc.performSearch(cityName),
    expect: () => [
      const FetchingForecastState(),
      ErrorFetchingForecastState(GenericException())
    ],
    verify: (_) {
      verify(weatherRepository.forecast(cityName)).called(1);
    },
  );

}
