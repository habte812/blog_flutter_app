class UserModel {
  final int id;
  final String userName;
  final String userEmail;
  final String? userBio;
  final String? profileImage;
  final int totalPosts;
  final String joinedAt;
  final int followings;
  final int followers;

  UserModel({
    required this.id,
    required this.userName,
    required this.userEmail,
    this.userBio,
    this.profileImage,
    required this.totalPosts,
    required this.joinedAt,
    required this.followers,
    required this.followings,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['name'],
      userBio: json['bio'],
      userEmail: json['email'],
      totalPosts: json['posts_count'] ?? 0,
      profileImage: json['profile_picture_url'],
      joinedAt: json['joined_at'],
      followers: json['followers_count'] ?? 0,
      followings: json['followings_count'] ?? 0,
    );
  }
}

class AuthorProfileModel {
  final int id;
  final String userName;
  final String? userBio;
  final String? profileImage;
  final int totalPosts;
  final String joinedAt;
  final bool isOwner;
  final int followings;
  final int followers;
  final bool isFollowing;

  AuthorProfileModel({
    required this.id,
    required this.userName,
    this.userBio,
    this.profileImage,
    required this.totalPosts,
    required this.joinedAt,
    required this.isOwner,
    required this.followers,
    required this.followings,
    required this.isFollowing,
  });

  factory AuthorProfileModel.fromJson(Map<String, dynamic> json) {
    return AuthorProfileModel(
      id: json['id'],
      userName: json['name'],
      userBio: json['bio'],
      totalPosts: json['posts_count'] ?? 0,
      profileImage: json['profile_picture_url'],
      joinedAt: json['joined_at'],
      isOwner: json['is_owner'],
      followers: json['followers_count'],
      followings: json['followings_count'],
      isFollowing: json['is_following'],
    );
  }
}
