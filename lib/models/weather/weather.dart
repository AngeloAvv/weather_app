import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';

/// The Weather model
@freezed
class Weather with _$Weather {
  /// The helper factory method to generate the Weather constructor
  factory Weather({
    required final int id,
    required final String main,
    required final String description,
    required final String icon,
  }) = WeatherData;
}
