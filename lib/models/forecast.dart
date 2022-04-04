import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/misc/converters/date_time_converter.dart';
import 'package:weather/models/clouds.dart';
import 'package:weather/models/main.dart';
import 'package:weather/models/rain.dart';
import 'package:weather/models/snow.dart';
import 'package:weather/models/sys.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/models/wind.dart';

part 'forecast.freezed.dart';
part 'forecast.g.dart';

/// The Forecast model
@freezed
class Forecast with _$Forecast {
  /// The helper factory method to generate the Forecast constructor
  factory Forecast({
    @DateTimeConverter() required DateTime dt,
    required Main main,
    required List<Weather> weather,
    Clouds? clouds,
    Wind? wind,
    Rain? rain,
    Snow? snow,
    required int visibility,
    required double pop,
    required Sys sys,
    @JsonKey(name: 'dt_txt') required String dtTxt,
  }) = ForecastData;

  /// Factory method to generate a Forecast object starting from a json map of string,value
  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
}
