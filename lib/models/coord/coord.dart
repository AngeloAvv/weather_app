import 'package:freezed_annotation/freezed_annotation.dart';

part 'coord.freezed.dart';

/// The Coord model
@freezed
class Coord with _$Coord {
  /// The helper factory method to generate the Coord constructor
  factory Coord({
    required double lat,
    required double lon,
  }) = CoordData;
}
