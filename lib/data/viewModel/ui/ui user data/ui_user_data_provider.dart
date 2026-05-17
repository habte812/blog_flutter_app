import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/ui/ui_user_model.dart';
import 'package:tech_node/data/services/image%20services/image_processing_service.dart';

part 'ui_user_data_provider.g.dart';

@riverpod
class UiUserDataProvider extends _$UiUserDataProvider {
  late TextEditingController userNameController;
  late TextEditingController userBioController;
  @override
  UiUserModel build() {
    userNameController = TextEditingController();
    userBioController = TextEditingController();
    ref.onDispose(() {
      userBioController.dispose();
      userNameController.dispose();
    });
    return UiUserModel();
  }

  // void syncProfilePicture(String? url) {
  //   if (state.userProfile == null && url != null) {
  //     state = state.copyWith(userProfile: url);
  //   }
  // }

  Future<void> pickAndProcessProfileImage() async {
    await ref
        .read(imageProcessingServiceProvider.notifier)
        .pickimageAndCrop(
          quality: 80,
          ratioX: 1,
          ratioY: 1,
          aspectRatio: CropAspectRatioPreset.square,
        );
    final resultData = ref.read(imageProcessingServiceProvider);

    resultData.whenData((pic) {
      if (pic != null) {
        state = state.copyWith(userProfile: pic);
      }
    });
  }

  UiUserModel prepareDataForUpdate() {
    return UiUserModel(
      userName: userNameController.text.trim(),
      userBio: userBioController.text.trim(),
      userProfile: state.userProfile,
    );
  }
}
