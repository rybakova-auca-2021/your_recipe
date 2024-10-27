class PasswordSetEntity {
  final String userId;
  final String newPassword;
  final String confirmPassword;

  PasswordSetEntity({
    required this.userId,
    required this.newPassword,
    required this.confirmPassword,
  });
}
