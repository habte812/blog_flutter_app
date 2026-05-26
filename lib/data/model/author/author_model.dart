class AuthorModel {
  final int id;
  final String name;
  final String userRole;
  final String? profilePicture;
  final bool isFollowing;
  AuthorModel({
    required this.id,
    required this.name,
    this.profilePicture,
    required this.isFollowing,
    required this.userRole
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'],
      name: json['name'],
      userRole: json['role'],
      profilePicture: json['profile_picture_url'],
      isFollowing: json['is_following'],
    );
  }
}
