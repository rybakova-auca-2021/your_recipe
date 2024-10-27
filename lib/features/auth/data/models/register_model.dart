class RegisterModel {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    };
  }

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirm_password'],
    );
  }
}
