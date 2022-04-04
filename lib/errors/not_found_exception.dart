/// The not found exception thrown if the city doesn't exist
class NotFoundException implements Exception {
  /// The city to be looking for
  final String city;

  /// The NotFoundException constructor
  NotFoundException(this.city);
}
