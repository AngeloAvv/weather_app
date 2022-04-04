import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/models/coord.dart';

part 'city.freezed.dart';
part 'city.g.dart';

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

  /// Factory method to generate a City object starting from a json map of string,value
  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
