import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/ui/ui_user_model.dart';
import 'package:tech_node/data/model/user/user_model.dart';
import 'package:tech_node/data/repository/user/user_data_repository.dart';
part 'user_notifier.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  FutureOr<UserModel> build() {
    final livekeep = ref.keepAlive();
    final timer = Timer(const Duration(minutes: 3), () => livekeep.close());
    ref.onDispose(() => timer.cancel());
    return ref.read(userDataRepositoryProvider).fetchUserProfile();
  }

  Future<void> refreshProfile() async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(userDataRepositoryProvider).fetchUserProfile(),
    );
    if (!ref.mounted) return;
    state = result;
  }
}

@riverpod
class ProfileUpdateNotifier extends _$ProfileUpdateNotifier {
  @override
  FutureOr<UserModel?> build() => null;

  Future<void> updateMyProfile({required UiUserModel userdata}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final updateProfile = await ref
          .read(userDataRepositoryProvider)
          .updateMyProfile(
            name: userdata.userName,
            bio: userdata.userBio,
            profileImage: userdata.userProfile,
          );
      ref.invalidate(userProvider);
      return updateProfile;
    });
  }
}
