class HttpException implements Exception{
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}
//Enter a valid email address.
//Ensure this field has at least 8 characters.
//That email is already in use.
