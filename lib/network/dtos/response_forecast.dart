import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/models/city.dart';
import 'package:weather/models/forecast.dart';

part 'response_forecast.freezed.dart';
part 'response_forecast.g.dart';

/// Data Transfer Object to store the response data coming from the rest client
@freezed
class ResponseForecast with _$ResponseForecast {
  /// Helper to generate the constructor for the model ResponseForecast
  factory ResponseForecast({
    @JsonKey(name: 'cod') required String code,
    @JsonKey(name: 'message') required int message,
    @JsonKey(name: 'list') required List<Forecast> forecast,
    @JsonKey(name: 'city') required City city,
  }) = ResponseForecastData;

  /// Method to create a ResponseForecast from a json map of string,dynamic
  factory ResponseForecast.fromJson(Map<String, dynamic> json) =>
      _$ResponseForecastFromJson(json);
}
