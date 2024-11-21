import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';
import 'package:weather/services/network/dtos/coord/coord_dto.dart';

part 'city_dto.freezed.dart';

part 'city_dto.g.dart';

/// The CityDTO
@freezed
class CityDTO extends DTO with _$CityDTO {
  /// The helper factory method to generate the CityDTO constructor
  factory CityDTO({
    required int id,
    required String name,
    required CoordDTO coord,
    required String country,
    required int population,
    required int timezone,
    required int sunrise,
    required int sunset,
  }) = CityDTOData;

  /// Factory method to generate a CityDTO object starting from a json map of string,value
  factory CityDTO.fromJson(Map<String, dynamic> json) =>
      _$CityDTOFromJson(json);
}
