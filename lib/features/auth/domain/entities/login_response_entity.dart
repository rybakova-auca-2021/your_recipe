class LoginResponseEntity {
  final int userId;
  final String accessToken;
  final String refreshToken;

  LoginResponseEntity({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });
}
