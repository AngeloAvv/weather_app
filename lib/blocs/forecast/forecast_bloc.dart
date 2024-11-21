import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/models/city/city.dart';
import 'package:weather/models/forecast/forecast.dart';
import 'package:weather/repositories/weather_repository.dart';

part 'forecast_bloc.freezed.dart';

part 'forecast_event.dart';

part 'forecast_state.dart';

/// The forecast BLoC component to fetch forecast data and emit the proper state accordingly
class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  /// The weather repository
  final WeatherRepository repository;

  /// The forecast BLoC component constructor
  ForecastBloc({
    required this.repository,
  }) : super(const InitialCityState()) {
    on<FetchForecastEvent>(_onFetch);
  }

  /// Method to retrieve the weather of a city
  void performSearch(String city, {String? locale}) => add(
        FetchForecastEvent(
          city,
          locale: locale,
        ),
      );

  void _onFetch(
    FetchForecastEvent event,
    Emitter<ForecastState> emit,
  ) async {
    emit(const FetchingForecastState());

    try {
      final (forecasts, city) = await repository.forecast(
        event.city,
        language: event.locale,
      );

      emit(FetchedForecastState(
        forecasts: forecasts,
        city: city,
      ));
    } catch (error) {
      emit(ErrorFetchingForecastState(error));
    }
  }
}
