import 'package:freezed_annotation/freezed_annotation.dart';

part 'sys.freezed.dart';

/// The Sys model
@freezed
class Sys with _$Sys {
  /// The helper factory method to generate the Sys constructor
  factory Sys(String pod) = SysData;
}
