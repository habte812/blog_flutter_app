import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_sacffold_message.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:tech_node/data/viewModel/auth/auth_notifier.dart';
import 'package:tech_node/data/viewModel/user/user_notifier.dart';
import 'package:tech_node/view/create/widgets/reader%20user/author_process_steps.dart';
import 'package:tech_node/view/create/widgets/reader%20user/reader_user_app_bar.dart';
import 'package:tech_node/view/create/widgets/reader%20user/what_you_get_after.dart';

class IfUserIsReader extends StatelessWidget {
  const IfUserIsReader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const ReaderUserAppBar(),
            const SliverPadding(padding: EdgeInsets.only(top: 18)),
            SliverToBoxAdapter(
              child: Icon(
                LucideIcons.userCheck2,
                size: 50,
                color: context.primary,
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextStyle(
                  text: "Be an Author",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white,
                  letterSpacing: -0.5,
                  textAlign: .center,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 10)),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: CustomTextStyle(
                  text:
                      "Upgrade your profile to an Author account to gain full access to rich text tools, advanced blog analytics, and instant publishing networks.",
                  fontSize: 14,
                  textColor: Colors.white38,
                  textAlign: .center,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 32)),
            const SliverToBoxAdapter(child: AuthorProcessSteps()),
            const SliverPadding(padding: EdgeInsets.only(top: 32)),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextStyle(
                  text: "WHAT YOU GET AS AN AUTHOR",
                  textColor: Colors.white24,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 16)),

            const SliverToBoxAdapter(
              child: WhatYouGetAfter(
                icon: LucideIcons.fileSpreadsheet,
                title: "Advanced Markdown Editor",
                description:
                    "Clean blocks, native code highlighting, and auto-save drafts.",
              ),
            ),
            const SliverToBoxAdapter(
              child: WhatYouGetAfter(
                icon: LucideIcons.lineChart,
                title: "Audience Analytics Dashboard",
                description:
                    "Deep dive insights into read time, view graphs, and referral paths.",
              ),
            ),
            const SliverToBoxAdapter(
              child: WhatYouGetAfter(
                icon: LucideIcons.badgeCheck,
                title: "Verified Creator Badge",
                description:
                    "A digital signature badge displaying author credibility to readers.",
              ),
            ),

            const SliverPadding(padding: EdgeInsets.only(top: 40)),

            Consumer(
              builder: (context, ref, child) {
                final userState = ref.watch(authProvider).status;
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomButton(
                      onPressed: () {
                        if (userState == AuthStatus.unverified) {
                          CustomScaffoldMessage.show(
                            context,
                            message: "Please first verify your email",
                            isError: true,
                          );
                        }
                      },
                      label: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextStyle(
                            text: "Begin Verification Profile",
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          SizedBox(width: 8),
                          Icon(LucideIcons.arrowRight, size: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }
}
