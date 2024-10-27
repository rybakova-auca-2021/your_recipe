class PasswordSetModel {
  final String userId;
  final String newPassword;
  final String confirmPassword;

  PasswordSetModel({
    required this.userId,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
  }

  factory PasswordSetModel.fromJson(Map<String, dynamic> json) {
    return PasswordSetModel(
      userId: json['user_id'],
      newPassword: json['new_password'],
      confirmPassword: json['confirm_password'],
    );
  }
}
