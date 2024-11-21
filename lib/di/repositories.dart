part of 'dependency_injector.dart';

final List<RepositoryProvider> _repositories = [
  RepositoryProvider<WeatherRepository>(
    create: (context) => WeatherRepositoryImpl(
      restClient: context.read(),
      cityMapper: const CityMapperImpl(),
      forecastMapper: const ForecastMapperImpl(),
      logger: context.read(),
    ),
  ),
];
