part of 'forecast_bloc.dart';

/// The forecast BLoC state class
@freezed
class ForecastState with _$ForecastState {
  /// Helper method to generate a state that represents an initial undefined city
  const factory ForecastState.undefinedCityState() = UndefinedCityState;

  /// Helper method to generate a state that represents a fetched forecast for a particular city
  const factory ForecastState.fetchedForecastState(ResponseForecast forecast) =
      FetchedForecastState;

  /// Helper method to generate a state that identifies the fetching data process
  const factory ForecastState.fetchingForecastState() = FetchingForecastState;

  /// Helper method to generate a state that identifies a generic error
  const factory ForecastState.errorForecastState(dynamic error) =
      ErrorForecastState;

  /// Helper method to generate a state that identifies a no internet connection
  const factory ForecastState.noInternetErrorForecastState() =
      NoInternetErrorForecastState;

  /// Helper method to generate a state that represents a forecast not found for a particular city
  const factory ForecastState.notFoundErrorForecastState(String city) =
      NotFoundErrorForecastState;

  /// Helper method to generate a state that identifies a generic error
  const factory ForecastState.invalidAPITokenErrorForecastState() =
      InvalidAPITokenErrorForecastState;

  /// Helper method to generate a state that identifies an empty city error
  const factory ForecastState.emptyCityErrorForecastState() =
      EmptyCityErrorForecastState;
}
