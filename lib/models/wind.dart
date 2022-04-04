import 'package:freezed_annotation/freezed_annotation.dart';

part 'wind.freezed.dart';
part 'wind.g.dart';

/// The wind model
@freezed
class Wind with _$Wind {
  /// The helper factory method to generate the Wind constructor
  factory Wind({
    required double speed,
    required int deg,
  }) = WindData;

  /// Factory method to generate a Wind object starting from a json map of string,value
  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
}
