import 'package:freezed_annotation/freezed_annotation.dart';

part 'snow.freezed.dart';

/// The Snow model
@freezed
class Snow with _$Snow {
  /// The helper factory method to generate the Snow constructor
  factory Snow(double threeHours) = SnowData;
}
