import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';
import 'package:weather/misc/converters/date_time_converter.dart';
import 'package:weather/services/network/dtos/clouds/clouds_dto.dart';
import 'package:weather/services/network/dtos/main/main_dto.dart';
import 'package:weather/services/network/dtos/rain/rain_dto.dart';
import 'package:weather/services/network/dtos/snow/snow_dto.dart';
import 'package:weather/services/network/dtos/sys/sys_dto.dart';
import 'package:weather/services/network/dtos/weather/weather_dto.dart';
import 'package:weather/services/network/dtos/wind/wind_dto.dart';

part 'forecast_dto.freezed.dart';
part 'forecast_dto.g.dart';

/// The ForecastDTO
@freezed
class ForecastDTO extends DTO with _$ForecastDTO {
  /// The helper factory method to generate the ForecastDTO constructor
  factory ForecastDTO({
    @DateTimeConverter() required DateTime dt,
    required MainDTO main,
    required List<WeatherDTO> weather,
    CloudsDTO? clouds,
    WindDTO? wind,
    RainDTO? rain,
    SnowDTO? snow,
    required int visibility,
    required double pop,
    required SysDTO sys,
    @JsonKey(name: 'dt_txt') required String dtTxt,
  }) = ForecastDTOData;

  /// Factory method to generate a ForecastDTO object starting from a json map of string,value
  factory ForecastDTO.fromJson(Map<String, dynamic> json) =>
      _$ForecastDTOFromJson(json);
}
