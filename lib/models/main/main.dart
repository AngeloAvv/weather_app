import 'package:freezed_annotation/freezed_annotation.dart';

part 'main.freezed.dart';

/// The Main model
@freezed
class Main with _$Main {
  /// The helper factory method to generate the Main constructor
  factory Main({
    required double temp,
    required double feelsLike,
    required double tempMin,
    required double tempMax,
    required int pressure,
    required int seaLevel,
    required int grndLevel,
    required int humidity,
    required double tempKf,
  }) = MainData;
}
