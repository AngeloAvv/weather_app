import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'coord_dto.freezed.dart';
part 'coord_dto.g.dart';

/// The CoordDTO
@freezed
class CoordDTO extends DTO with _$CoordDTO {
  /// The helper factory method to generate the CoordDTO constructor
  factory CoordDTO({
    required double lat,
    required double lon,
  }) = CoordDTOData;

  /// Factory method to generate a CoordDTO object starting from a json map of string,value
  factory CoordDTO.fromJson(Map<String, dynamic> json) => _$CoordDTOFromJson(json);
}
