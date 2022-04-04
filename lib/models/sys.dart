import 'package:freezed_annotation/freezed_annotation.dart';

part 'sys.freezed.dart';
part 'sys.g.dart';

/// The Sys model
@freezed
class Sys with _$Sys {
  /// The helper factory method to generate the Sys constructor
  factory Sys(String pod) = SysData;

  /// Factory method to generate a Sys object starting from a json map of string,value
  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);
}
