import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_field.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/services/image%20services/image_processing_service.dart';
import 'package:tech_node/data/viewModel/ui/ui%20user%20data/ui_user_data_provider.dart';
import 'package:tech_node/data/viewModel/user/user_notifier.dart';
import 'package:tech_node/view/profile/widgets/update_button.dart';

class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(userProvider);
    final uiNotifier = ref.read(uiUserDataProviderProvider.notifier);
    currentUserAsync.whenData((user) {
      if (uiNotifier.userNameController.text.isEmpty) {
        uiNotifier.userNameController.text = user.userName;
        uiNotifier.userBioController.text = user.userBio ?? '';
        // Future.microtask(() {
        //    ref.read(uiUserDataProviderProvider.notifier).syncProfilePicture(user.profileImage);
        // });
      }
    });
    final userProfilePic = ref.watch(
      uiUserDataProviderProvider.select((pic) => pic.userProfile),
    );
    final imageProcesser = ref.watch(imageProcessingServiceProvider);
    final isProcessing = imageProcesser.isLoading;
    final hasError = imageProcesser.hasError;
    final String theError = imageProcesser.error.toString();
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        title: const CustomTextStyle(
          text: "Edit Profile",
          textColor: Colors.white,
          fontSize: 18,
        ),
        actions: [const UpdateProfileButton()],
      ),
      body: ListView(
        padding: const .all(20),
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white10,
                  backgroundImage: userProfilePic != null
                      ? (userProfilePic.startsWith('http') ||
                                userProfilePic.startsWith('https')
                            ? NetworkImage(userProfilePic) as ImageProvider
                            : FileImage(File(userProfilePic)))
                      : null,
                  child: (userProfilePic == null && !isProcessing)
                      ? const Icon(
                          LucideIcons.user,
                          size: 40,
                          color: Colors.white,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      ref
                          .read(uiUserDataProviderProvider.notifier)
                          .pickAndProcessProfileImage();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration:  BoxDecoration(
                        color: context.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (isProcessing || hasError)
            CustomTextStyle(
              text: isProcessing
                  ? 'Loading...'
                  : hasError
                  ? theError
                  : "JPG, PNG, Webp up to 2MB",
              fontSize: 13,
              textColor: hasError ? Colors.red : Colors.white54,
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: ref
                .read(uiUserDataProviderProvider.notifier)
                .userNameController,
            label: "User Name",
            maxLines: 1,
            maxLength: 25,
            contentPadding: const .all(10),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: ref
                .read(uiUserDataProviderProvider.notifier)
                .userBioController,
            label: "Bio",
            maxLines: 3,
            contentPadding: const .all(10),
            maxLength: 55,
          ),
          const SizedBox(height: 20),
          const CustomTextStyle(
            text: "Private Information",
            textColor: Colors.white54,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: currentUserAsync.value?.userEmail ?? "Email",
            readOnly: true,
            maxLines: 1,
            contentPadding: const .all(10),
          ),
        ],
      ),
    );
  }
}
