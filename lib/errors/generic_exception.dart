/// A generic exception thrown for unknown errors.
class GenericException implements Exception {
  /// Creates a [GenericException].
  const GenericException();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is GenericException && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
