import 'package:json_annotation/json_annotation.dart';

/// A date time converter to serialize from milliseconds int value to DateTime
class DateTimeConverter implements JsonConverter<DateTime, int> {
  /// DateTimeConverter constructor
  const DateTimeConverter();

  @override
  DateTime fromJson(int value) => DateTime.fromMillisecondsSinceEpoch(
        value * 1000,
        isUtc: true,
      );

  @override
  int toJson(DateTime object) => throw UnimplementedError();
}
