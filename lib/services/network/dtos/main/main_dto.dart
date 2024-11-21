import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'main_dto.freezed.dart';
part 'main_dto.g.dart';

/// The MainDTO
@freezed
class MainDTO extends DTO with _$MainDTO {
  /// The helper factory method to generate the MainDTO constructor
  factory MainDTO({
    required double temp,
    @JsonKey(name: 'feels_like') required double feelsLike,
    @JsonKey(name: 'temp_min') required double tempMin,
    @JsonKey(name: 'temp_max') required double tempMax,
    required int pressure,
    @JsonKey(name: 'sea_level') required int seaLevel,
    @JsonKey(name: 'grnd_level') required int grndLevel,
    required int humidity,
    @JsonKey(name: 'temp_kf') required double tempKf,
  }) = MainDTOData;

  /// Factory method to generate a MainDTO object starting from a json map of string,value
  factory MainDTO.fromJson(Map<String, dynamic> json) => _$MainDTOFromJson(json);
}
