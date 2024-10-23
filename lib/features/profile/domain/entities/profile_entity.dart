class ProfileEntity {
  final int id;
  final String? email;
  final String username;
  final String profilePhoto;

  ProfileEntity({
    required this.id,
    this.email,
    required this.username,
    required this.profilePhoto,
  });
}
