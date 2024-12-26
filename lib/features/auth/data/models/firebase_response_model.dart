class FirebaseResponseModel {
  final String accessToken;
  final String refreshToken;
  final String message;
  final int userId;

  FirebaseResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.message,
    required this.userId,
  });

  factory FirebaseResponseModel.fromJson(Map<String, dynamic> json) {
    return FirebaseResponseModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      message: json['message'],
      userId: json['user_id'],
    );
  }
}
