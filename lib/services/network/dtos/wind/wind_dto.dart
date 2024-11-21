import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'wind_dto.freezed.dart';
part 'wind_dto.g.dart';

/// The wind model
@freezed
class WindDTO extends DTO with _$WindDTO {
  /// The helper factory method to generate the WindDTO constructor
  factory WindDTO({
    required double speed,
    required int deg,
  }) = WindDTOData;

  /// Factory method to generate a WindDTO object starting from a json map of string,value
  factory WindDTO.fromJson(Map<String, dynamic> json) => _$WindDTOFromJson(json);
}
