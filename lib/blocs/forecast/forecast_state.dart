part of 'forecast_bloc.dart';

/// The forecast BLoC state class
@freezed
class ForecastState with _$ForecastState {
  /// Helper method to generate a state that identifies an undefined city
  const factory ForecastState.initial() = InitialCityState;

  /// Helper method to generate a state that identifies the fetching data process
  const factory ForecastState.fetching() = FetchingForecastState;

  /// Helper method to generate a state that represents a fetched forecast for a particular city
  const factory ForecastState.fetched({
    @Default([]) List<Forecast> forecasts,
    required City city,
  }) = FetchedForecastState;

  /// Helper method to generate a state that identifies an error
  const factory ForecastState.errorFetching(dynamic error) =
      ErrorFetchingForecastState;
}
