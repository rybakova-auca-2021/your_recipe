class PasswordResetModel {
  final String email;

  PasswordResetModel({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  factory PasswordResetModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetModel(
      email: json['email'],
    );
  }
}
