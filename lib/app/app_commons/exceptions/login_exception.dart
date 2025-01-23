enum LoginExceptionType {
  invalidCredentials,
  serverResponseError,
  unknown,
}

class LoginException implements Exception {
  LoginException({
    required this.errorType,
    this.message,
  });

  final LoginExceptionType errorType;
  final String? message;
}
