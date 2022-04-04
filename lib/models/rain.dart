import 'package:freezed_annotation/freezed_annotation.dart';

part 'rain.freezed.dart';
part 'rain.g.dart';

/// The Rain model
@freezed
class Rain with _$Rain {
  /// The helper factory method to generate the Rain constructor
  factory Rain(@JsonKey(name: '3h') double threeHours) = RainData;

  /// Factory method to generate a Rain object starting from a json map of string,value
  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);
}
