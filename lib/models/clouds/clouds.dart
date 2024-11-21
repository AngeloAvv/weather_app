import 'package:freezed_annotation/freezed_annotation.dart';

part 'clouds.freezed.dart';

/// The Clouds model
@freezed
class Clouds with _$Clouds {
  /// The helper factory method to generate the Clouds constructor
  factory Clouds(int all) = CloudsData;
}
