class Login {
  int statusCode;
  bool succeeded;
  String message;
  String error;
  String token;
  Login({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    required this.error,
    required this.token,
  });
}
