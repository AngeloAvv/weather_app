import 'package:freezed_annotation/freezed_annotation.dart';

part 'wind.freezed.dart';

/// The wind model
@freezed
class Wind with _$Wind {
  /// The helper factory method to generate the Wind constructor
  factory Wind({
    required double speed,
    required int deg,
  }) = WindData;
}
