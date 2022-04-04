import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/blocs/forecast/forecast_bloc.dart';
import 'package:weather/errors/not_found_exception.dart';
import 'package:weather/models/city.dart';
import 'package:weather/models/coord.dart';
import 'package:weather/network/dtos/response_forecast.dart';
import 'package:weather/repositories/weather_repository.dart';

import 'forecast_bloc_test.mocks.dart';

@GenerateMocks([
  Connectivity,
  Logger,
  WeatherRepository,
])
void main() {
  WeatherRepository? weatherRepository;
  Connectivity? connectivity;
  Logger? logger;

  setUp(() {
    weatherRepository = MockWeatherRepository();
    connectivity = MockConnectivity();
    logger = MockLogger();
  });

  blocTest<ForecastBloc, ForecastState>(('test search with an empty string'),
      build: () {
        when(connectivity?.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.wifi);

        return ForecastBloc(
          repository: weatherRepository!,
          connectivity: connectivity!,
          logger: logger!,
        );
      },
      act: (bloc) => bloc.performSearch(''),
      expect: () => [const EmptyCityErrorForecastState()]);

  blocTest<ForecastBloc, ForecastState>(('test search with an unknown city'),
      build: () {
        when(connectivity?.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.wifi);

        when(weatherRepository?.forecast(city: 'blablabla'))
            .thenThrow(NotFoundException('blablabla'));

        return ForecastBloc(
          repository: weatherRepository!,
          connectivity: connectivity!,
          logger: logger!,
        );
      },
      act: (bloc) => bloc.performSearch('blablabla'),
      expect: () => [
            const FetchingForecastState(),
            const NotFoundErrorForecastState('blablabla')
          ]);

  blocTest<ForecastBloc, ForecastState>(
      ('test search with an unconnected device'),
      build: () {
        when(connectivity?.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.none);

        return ForecastBloc(
          repository: weatherRepository!,
          connectivity: connectivity!,
          logger: logger!,
        );
      },
      act: (bloc) => bloc.performSearch('bari'),
      expect: () => [const NoInternetErrorForecastState()]);

  blocTest<ForecastBloc, ForecastState>(('test search with success'),
      build: () {
        when(connectivity?.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.wifi);

        when(weatherRepository?.forecast(city: 'bari'))
            .thenAnswer((_) async => ResponseForecast(
                  city: City(
                    id: 0,
                    name: '',
                    coord: Coord(lat: 0, lon: 0),
                    country: '',
                    population: 0,
                    timezone: 0,
                    sunrise: 0,
                    sunset: 0,
                  ),
                  code: '',
                  forecast: [],
                  message: 0,
                ));

        return ForecastBloc(
          repository: weatherRepository!,
          connectivity: connectivity!,
          logger: logger!,
        );
      },
      act: (bloc) => bloc.performSearch('bari'),
      expect: () => [
            const FetchingForecastState(),
            isA<FetchedForecastState>(),
          ]);
}
