import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/models/clouds/clouds.dart';
import 'package:weather/models/main/main.dart';
import 'package:weather/models/rain/rain.dart';
import 'package:weather/models/snow/snow.dart';
import 'package:weather/models/sys/sys.dart';
import 'package:weather/models/weather/weather.dart';
import 'package:weather/models/wind/wind.dart';

part 'forecast.freezed.dart';

/// The Forecast model
@freezed
class Forecast with _$Forecast {
  /// The helper factory method to generate the Forecast constructor
  factory Forecast({
    required DateTime dt,
    required Main main,
    required List<Weather> weather,
    Clouds? clouds,
    Wind? wind,
    Rain? rain,
    Snow? snow,
    required int visibility,
    required double pop,
    required Sys sys,
    required String dtTxt,
  }) = ForecastData;
}
