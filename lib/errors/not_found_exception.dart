/// The not found exception thrown if the city doesn't exist
class NotFoundException implements Exception {
  /// The city to be looking for
  final String city;

  /// The NotFoundException constructor
  const NotFoundException(this.city);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NotFoundException && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
