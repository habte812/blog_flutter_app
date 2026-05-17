class AuthModel {
  final String accessToken;
  final String tokenType;
  final String role;
  final String? refreshToken;
  final AuthUser authUser;

  AuthModel({
    required this.accessToken,
    this.refreshToken,
    required this.tokenType,
    required this.authUser,
    required this.role,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    accessToken: json["token"],
    refreshToken: json["refresh_token"],
    tokenType: json["token_type"],
    authUser: AuthUser.fromJson(json['user']),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "token": accessToken,
    "refresh_token": refreshToken,
    "token_type": tokenType,
    "user": {
      'is_verified': authUser.isVerified
    },
  };
}

class AuthUser {
  final bool isVerified;
  AuthUser({required this.isVerified});
  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      AuthUser(isVerified: json['is_verified']);
}
