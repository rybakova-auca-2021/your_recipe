class ProfileModel {
  final String? email;
  final String username;
  final String profilePhoto;

  ProfileModel({
    required this.email,
    required this.username,
    required this.profilePhoto
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'profile_photo': profilePhoto
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['email'],
      username: json['username'],
      profilePhoto: json['profile_photo']
    );
  }
}
