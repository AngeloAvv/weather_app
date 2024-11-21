import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'weather_dto.freezed.dart';
part 'weather_dto.g.dart';

/// The WeatherDTO model
@freezed
class WeatherDTO extends DTO with _$WeatherDTO {
  /// The helper factory method to generate the WeatherDTO constructor
  factory WeatherDTO({
    required final int id,
    required final String main,
    required final String description,
    required final String icon,
  }) = WeatherDTOData;

  /// Factory method to generate a WeatherDTO object starting from a json map of string,value
  factory WeatherDTO.fromJson(Map<String, dynamic> json) =>
      _$WeatherDTOFromJson(json);
}
