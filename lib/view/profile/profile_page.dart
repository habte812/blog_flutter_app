import 'package:flutter/material.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_banner_card.dart';
import 'package:tech_node/view/profile/widgets/profile_bio_and_total.dart';
import 'package:tech_node/view/profile/widgets/profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 260.0,
              pinned: true,
              stretch: true,
              backgroundColor: background,
              surfaceTintColor: background,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                expandedTitleScale: 1.2,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [primary, background],
                        ),
                      ),
                    ),
                    ProfileBioAndTotal(),
                  ],
                ),
              ),
              actions: [ProfileMenu()],
            ),
            SliverPadding(
              padding: .all(16),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: PersistentBannerDelegate(
                  child: const CustomBannerCard(),
                ),
              ),
            ),
            // SliverToBoxAdapter(child: SizedBox(height: 1000)),
          ],
        ),
      ),
    );
  }
}
