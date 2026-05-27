import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_banner_card.dart';
import 'package:tech_node/core/custom/custom_loading.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_field.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/model/pagination/paginated_response_model.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/blog%20comments/comments_notifier.dart';
import 'package:tech_node/view/detail%20post/widgets/blog%20comments/provider/active%20reply/active_reply_notifier.dart';

class CommentInputField extends HookConsumerWidget {
  final String postId;
  const CommentInputField({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    final replyState = ref.watch(activeReplyProvider);
    final userStates = ref.watch(authProvider).status;
    ref.listen(authProvider, (previous, next) {
      if (next.lastAction == AuthAction.emailVerification) {
        if (previous?.status == AuthStatus.loading &&
            next.status != AuthStatus.error) {
          CustomScaffoldMessage.show(
            context,
            message: 'Email verification link has been sent to your email',
          );
        }

        if (previous?.status == AuthStatus.loading &&
            next.status == AuthStatus.error &&
            next.errorMessage != null) {
          CustomScaffoldMessage.show(
            context,
            message: next.errorMessage!,
            isError: true,
          );
        }
      }
    });
    ref.listen(activeReplyProvider, (pre, nex) {
      if (nex.parentId != null) {
        focusNode.requestFocus();
      }
    });
    ref.listen(fetchBlogCommentsProvider(postId), (prev, nex) {
      if (nex.status == PaginationStatus.failure) {
        CustomScaffoldMessage.show(
          context,
          message: nex.errorMessage.toString(),
          isError: true,
        );
      }
    });
    final isValid = useListenableSelector(
      controller,
      () => controller.text.trim().isNotEmpty,
    );
    if (userStates == AuthStatus.unauthenticated) {
      return SizedBox(
        height: 70,
        child: CustomBannerCard(
          title: "Welcome to BlogNode",
          subTitle: "Please login to continue",
          prefixIcon: LucideIcons.hand,
          buttonIcon: LucideIcons.logIn,
          buttonTitle: "Login",
          onPressed: () => context.pushNamed('login'),
        ),
      );
    }
    if (userStates == AuthStatus.unverified) {
      return SizedBox(
        height: 70,
        child: CustomBannerCard(
          title: "Verify Your Email",
          subTitle: "Please verify your email to continue",
          prefixIcon: LucideIcons.mailWarning,
          buttonIcon: Icons.refresh,
          buttonTitle: "Resend ",
          onPressed: () {
            ref.read(authProvider.notifier).sendEmailVerification();
          },
        ),
      );
    }
    if (userStates == AuthStatus.loading) {
      return const SizedBox(height: 1, child: CustomLineLoading());
    }
    return Column(
      children: [
        if (replyState.parentId != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: context.primary,
            child: Row(
              children: [
                Expanded(
                  child: CustomTextStyle(
                    text: "Replying to @${replyState.replyingToName}",
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      ref.read(activeReplyProvider.notifier).cancelReply(),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 8,
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  minLines: 1,
                  maxLines: 5,
                  maxLength: 1000,
                  controller: controller,
                  focusNode: focusNode,
                  hintText: replyState.parentId != null
                      ? 'write a reply...'
                      : 'write a comment...',
                ),
              ),
              const SizedBox(width: 8),
              Consumer(
                builder: (context, ref, child) {
                  final addcomment = ref.watch(
                    fetchBlogCommentsProvider(postId),
                  );
                  return IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        isValid ? context.primary : card,
                      ),
                    ),
                    onPressed: isValid || addcomment.isLoading
                        ? () {
                            ref
                                .read(
                                  fetchBlogCommentsProvider(postId).notifier,
                                )
                                .addComment(
                                  content: controller.text.trim(),

                                  parentId: replyState.parentId,
                                );
                            controller.clear();
                            ref
                                .read(activeReplyProvider.notifier)
                                .cancelReply();
                            focusNode.unfocus();
                          }
                        : null,
                    icon: const Icon(
                      LucideIcons.send,
                      size: 20,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
