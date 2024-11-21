import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';
import 'package:weather/services/network/dtos/city/city_dto.dart';
import 'package:weather/services/network/dtos/forecast/forecast_dto.dart';

part 'forecast_response.freezed.dart';

part 'forecast_response.g.dart';

/// Data Transfer Object to store the response data coming from the rest client
@freezed
class ForecastResponse extends DTO with _$ForecastResponse {
  /// Helper to generate the constructor for the model ForecastResponse
  factory ForecastResponse({
    @JsonKey(name: 'cod') required String code,
    @JsonKey(name: 'message') required int message,
    @JsonKey(name: 'list') required List<ForecastDTO> forecast,
    @JsonKey(name: 'city') required CityDTO city,
  }) = ForecastResponseData;

  /// Method to create a ForecastResponse from a json map of string,dynamic
  factory ForecastResponse.fromJson(Map<String, dynamic> json) =>
      _$ForecastResponseFromJson(json);
}
