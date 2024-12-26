class FirebaseModel {
  final String idToken;

  FirebaseModel({required this.idToken});

  Map<String, dynamic> toJson() {
    return {'id_token': idToken};
  }
}
