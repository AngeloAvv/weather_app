import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/models/coord/coord.dart';

part 'city.freezed.dart';

/// The City model
@freezed
class City with _$City {
  /// The helper factory method to generate the City constructor
  factory City({
    required int id,
    required String name,
    required Coord coord,
    required String country,
    required int population,
    required int timezone,
    required int sunrise,
    required int sunset,
  }) = CityData;
}
