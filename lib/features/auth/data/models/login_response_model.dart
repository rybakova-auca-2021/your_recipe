class LoginResponseModel {
  final int userId;
  final String accessToken;
  final String refreshToken;

  LoginResponseModel({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      userId: json['user_id'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
