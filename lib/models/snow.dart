import 'package:freezed_annotation/freezed_annotation.dart';

part 'snow.freezed.dart';
part 'snow.g.dart';

/// The Snow model
@freezed
class Snow with _$Snow {
  /// The helper factory method to generate the Snow constructor
  factory Snow(@JsonKey(name: '3h') double threeHours) = SnowData;

  /// Factory method to generate a Snow object starting from a json map of string,value
  factory Snow.fromJson(Map<String, dynamic> json) => _$SnowFromJson(json);
}
