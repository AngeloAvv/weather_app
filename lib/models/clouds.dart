import 'package:freezed_annotation/freezed_annotation.dart';

part 'clouds.freezed.dart';
part 'clouds.g.dart';

/// The Clouds model
@freezed
class Clouds with _$Clouds {
  /// The helper factory method to generate the Clouds constructor
  factory Clouds(int all) = CloudsData;

  /// Factory method to generate a Clouds object starting from a json map of string,value
  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
}
