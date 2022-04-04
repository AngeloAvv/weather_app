/// An extension on the double scalar type to round its value and convert to string
extension DoubleExtension on double {
  /// Rounds its value and convert to string
  String get flatDouble =>
      this - round() != 0 ? toString() : round().toString();
}
