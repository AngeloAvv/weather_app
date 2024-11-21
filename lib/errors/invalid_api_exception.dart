/// The invalid API exception thrown if the API key is invalid.
class InvalidAPIException implements Exception {
  /// Creates a [InvalidAPIException].
  const InvalidAPIException();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is InvalidAPIException && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
