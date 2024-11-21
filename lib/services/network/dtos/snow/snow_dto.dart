import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'snow_dto.freezed.dart';
part 'snow_dto.g.dart';

/// The SnowDTO
@freezed
class SnowDTO extends DTO with _$SnowDTO {
  /// The helper factory method to generate the SnowDTO constructor
  factory SnowDTO(@JsonKey(name: '3h') double threeHours) = SnowDTOData;

  /// Factory method to generate a SnowDTO object starting from a json map of string,value
  factory SnowDTO.fromJson(Map<String, dynamic> json) => _$SnowDTOFromJson(json);
}
