class AuthModel {
  final String accessToken;
  final String tokenType;
  final String? refreshToken;
  final AuthUser authUser;

  AuthModel({
    required this.accessToken,
    this.refreshToken,
    required this.tokenType,
    required this.authUser,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    accessToken: json["token"],
    refreshToken: json["refresh_token"],
    tokenType: json["token_type"],
    authUser: AuthUser.fromJson(json['user']),
  );

  Map<String, dynamic> toJson() => {
    "token": accessToken,
    "refresh_token": refreshToken,
    "token_type": tokenType,
    "user": authUser.toJson(),
  };
}

class AuthUser {
  final bool isVerified;
  final String role;
  AuthUser({required this.isVerified, required this.role});
  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    isVerified: json['is_verified'] ?? false,
    role: json['role'] ?? 'guest',
  );
  Map<String, dynamic> toJson() => {"is_verified": isVerified, "role": role};
}
