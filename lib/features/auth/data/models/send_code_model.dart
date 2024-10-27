class SendCodeModel {
  final String code;
  final String userId;

  SendCodeModel({
    required this.code,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'user_id': userId,
    };
  }

  factory SendCodeModel.fromJson(Map<String, dynamic> json) {
    return SendCodeModel(
      code: json['code'],
      userId: json['user_id'],
    );
  }
}
