
class BlogException implements Exception{
    final String message;

  BlogException(this.message,);

  @override
  String toString() => message;
}