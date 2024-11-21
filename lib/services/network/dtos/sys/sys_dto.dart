import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'sys_dto.freezed.dart';
part 'sys_dto.g.dart';

/// The SysDTO model
@freezed
class SysDTO extends DTO with _$SysDTO {
  /// The helper factory method to generate the SysDTO constructor
  factory SysDTO(String pod) = SysDTOData;

  /// Factory method to generate a SysDTO object starting from a json map of string,value
  factory SysDTO.fromJson(Map<String, dynamic> json) => _$SysDTOFromJson(json);
}
