import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/viewModel/ui/ui%20user%20data/ui_user_data_provider.dart';
import 'package:tech_node/data/viewModel/user/user_notifier.dart';

class UpdateProfileButton extends StatefulHookConsumerWidget {
  const UpdateProfileButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends ConsumerState<UpdateProfileButton> {
  @override
  Widget build(BuildContext context) {
    final proUpdate = ref.watch(profileUpdateProvider);
    ref.listen(profileUpdateProvider, (pre, nex) {
      nex.whenOrNull(
        data: (data) {
          CustomScaffoldMessage.show(context, message: 'Updated Successfully');
          if (!context.mounted) return;
          context.pop();
        },
        error: (error, stackTrace) {
          if (!context.mounted) return;
          CustomScaffoldMessage.show(
            context,
            message: error.toString(),
            isError: true,
          );
        },
      );
    });
    useListenable(
      ref.read(uiUserDataProviderProvider.notifier).userNameController,
    );
    final isEmpty = ref
        .read(uiUserDataProviderProvider.notifier)
        .userNameController
        .text
        .trim()
        .isEmpty;
    return TextButton(
      onPressed: isEmpty || proUpdate.isLoading
          ? () {}
          : () {
              ref
                  .read(profileUpdateProvider.notifier)
                  .updateMyProfile(
                    userdata: ref
                        .read(uiUserDataProviderProvider.notifier)
                        .prepareDataForUpdate(),
                  );
            },
      child: CustomTextStyle(
        text: proUpdate.isLoading
            ? 'Loading...'
            : proUpdate.hasError
            ? 'Try agin'
            : "Save",
        textColor: isEmpty
            ? Colors.white54
            : proUpdate.hasError
            ? Colors.red
            : context.primary,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
