class ResetPasswordRequest {
  final String token;
  final String password;

  ResetPasswordRequest({
    required this.token,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'token': token,
    'password': password,
  };
}