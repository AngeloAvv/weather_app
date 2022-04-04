part of 'forecast_bloc.dart';

/// The forecast BLoC event class
@freezed
class ForecastEvent with _$ForecastEvent {
  /// The forecast event to retrieve weather for a city
  const factory ForecastEvent.fetchForecastEvent(
    String city, {
    String? locale,
  }) = FetchForecastEvent;
}
