class UiUserModel {
  final String userName;
  final String? userBio;
  final String? userProfile;

  UiUserModel({this.userName = '', this.userBio, this.userProfile});

  UiUserModel copyWith({
    String? userName,
    String? userBio,
    String? userProfile,
  }) {
    return UiUserModel(
      userBio: userBio ?? this.userBio,
      userName: userName ?? this.userName,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
