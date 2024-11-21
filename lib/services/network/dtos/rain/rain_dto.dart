import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'rain_dto.freezed.dart';
part 'rain_dto.g.dart';

/// The RainDTO
@freezed
class RainDTO extends DTO with _$RainDTO {
  /// The helper factory method to generate the RainDTO constructor
  factory RainDTO(@JsonKey(name: '3h') double threeHours) = RainDTOData;

  /// Factory method to generate a RainDTO object starting from a json map of string,value
  factory RainDTO.fromJson(Map<String, dynamic> json) => _$RainDTOFromJson(json);
}
