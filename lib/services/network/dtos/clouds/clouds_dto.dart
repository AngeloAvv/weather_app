import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'clouds_dto.freezed.dart';
part 'clouds_dto.g.dart';

/// The CloudsDTO
@freezed
class CloudsDTO extends DTO with _$CloudsDTO {
  /// The helper factory method to generate the CloudsDTO constructor
  factory CloudsDTO(int all) = CloudsDTOData;

  /// Factory method to generate a CloudsDTO object starting from a json map of string,value
  factory CloudsDTO.fromJson(Map<String, dynamic> json) => _$CloudsDTOFromJson(json);
}
