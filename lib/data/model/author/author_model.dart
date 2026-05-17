class AuthorModel {
  final int id;
  final String name;
  final String? profilePicture;
  final bool isFollowing;
  AuthorModel({
    required this.id,
    required this.name,
    this.profilePicture,
    required this.isFollowing,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'],
      name: json['name'],
      profilePicture: json['profile_picture_url'],
      isFollowing: json['is_following'],
    );
  }
}
