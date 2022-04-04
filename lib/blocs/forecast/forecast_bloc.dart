import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:weather/errors/invalid_api_exception.dart';
import 'package:weather/errors/not_found_exception.dart';
import 'package:weather/network/dtos/response_forecast.dart';
import 'package:weather/repositories/weather_repository.dart';

part 'forecast_bloc.freezed.dart';
part 'forecast_event.dart';
part 'forecast_state.dart';

/// The forecast BLoC component to fetch forecast data and emit the proper state accordingly
class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  /// The weather repository
  final WeatherRepository repository;

  /// The connectivity service
  final Connectivity connectivity;

  /// The logger service
  final Logger logger;

  /// The forecast BLoC component constructor
  ForecastBloc({
    required this.repository,
    required this.connectivity,
    required this.logger,
  }) : super(const UndefinedCityState()) {
    on<FetchForecastEvent>(_mapFetchForecastEventToState);
  }

  /// Method to retrieve the weather of a city
  void performSearch(String city, {String? locale}) => add(
        FetchForecastEvent(
          city,
          locale: locale,
        ),
      );

  void _mapFetchForecastEventToState(
      FetchForecastEvent event, Emitter<ForecastState> emit) async {
    if (event.city.isNotEmpty) {
      if ((await (connectivity.checkConnectivity())) !=
          ConnectivityResult.none) {
        emit(const FetchingForecastState());

        ResponseForecast? forecast;
        try {
          logger.d('Fetching forecast for city ${event.city}');
          forecast = await repository.forecast(
            city: event.city,
            language: event.locale,
          );
          logger.d('Fetched forecast for city ${event.city}');
        } on NotFoundException catch (error) {
          logger.e('Cannot find the current forecast for city ${event.city}');
          emit(NotFoundErrorForecastState(error.city));
        } on InvalidAPIException catch (_) {
          logger.e('Invalid API token');
          emit(const InvalidAPITokenErrorForecastState());
        } catch (error, stackTrace) {
          logger.e('Generic error', error, stackTrace);
          emit(ErrorForecastState(error));
        } finally {
          logger.d('Fetched the current forecast for city ${event.city}');
          if (forecast != null) {
            emit(FetchedForecastState(forecast));
          }
        }
      } else {
        logger.e('Internet is not available');
        emit(const NoInternetErrorForecastState());
      }
    } else {
      logger.e('Searching for empty city');
      emit(const EmptyCityErrorForecastState());
    }
  }
}
