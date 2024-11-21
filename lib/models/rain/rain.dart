import 'package:freezed_annotation/freezed_annotation.dart';

part 'rain.freezed.dart';

/// The Rain model
@freezed
class Rain with _$Rain {
  /// The helper factory method to generate the Rain constructor
  factory Rain(double threeHours) = RainData;
}
