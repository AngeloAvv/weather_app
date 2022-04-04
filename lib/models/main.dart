import 'package:freezed_annotation/freezed_annotation.dart';

part 'main.freezed.dart';
part 'main.g.dart';

/// The Main model
@freezed
class Main with _$Main {
  /// The helper factory method to generate the Main constructor
  factory Main({
    required double temp,
    @JsonKey(name: 'feels_like') required double feelsLike,
    @JsonKey(name: 'temp_min') required double tempMin,
    @JsonKey(name: 'temp_max') required double tempMax,
    required int pressure,
    @JsonKey(name: 'sea_level') required int seaLevel,
    @JsonKey(name: 'grnd_level') required int grndLevel,
    required int humidity,
    @JsonKey(name: 'temp_kf') required double tempKf,
  }) = MainData;

  /// Factory method to generate a Main object starting from a json map of string,value
  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
}
