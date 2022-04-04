import 'package:freezed_annotation/freezed_annotation.dart';

part 'coord.freezed.dart';
part 'coord.g.dart';

/// The Coord model
@freezed
class Coord with _$Coord {
  /// The helper factory method to generate the Coord constructor
  factory Coord({
    required double lat,
    required double lon,
  }) = CoordData;

  /// Factory method to generate a Coord object starting from a json map of string,value
  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
}
