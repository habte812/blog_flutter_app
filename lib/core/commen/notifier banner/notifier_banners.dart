import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/custom/custom_banner_card.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';

class NotifierBanner extends HookConsumerWidget {
  const NotifierBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).status;
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
    if (authState == AuthStatus.unauthenticated) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: PersistentHeaderDelegate(
          child: CustomBannerCard(
            title: "Welcome to BlogNode",
            subTitle: "Please login to continue",
            prefixIcon: LucideIcons.hand,
            buttonIcon: LucideIcons.logIn,
            buttonTitle: "Login",
            onPressed: () {
              if (!context.mounted) return;
              context.pushNamed('login');
            },
          ),
        ),
      );
    } else if (authState == AuthStatus.unverified) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: PersistentHeaderDelegate(
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
        ),
      );
    } else if (authState == AuthStatus.error) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: PersistentHeaderDelegate(
          child: CustomBannerCard(
            color: Colors.red,
            title: "Error",
            subTitle: "Something went wrong",
            prefixIcon: LucideIcons.alertCircle,
            buttonIcon: Icons.refresh,
            buttonTitle: "Retry",
            onPressed: () {
              ref.invalidate(authProvider);
            },
          ),
        ),
      );
    } else {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
  }
}
