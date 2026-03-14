import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/app/scroll_provider.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class AppMenu extends HookWidget {
  final Widget child;
  const AppMenu({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    int getCurrentIndex() {
      if (location.startsWith('/home')) return 0;
      if (location.startsWith('/explore')) return 1;
      if (location.startsWith('/saved')) return 2;
      if (location.startsWith('/settings')) return 3;
      return 0;
    }

    final selectedIndex = useState<int>(getCurrentIndex());
    final scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>());
    final isVisible = useState<bool>(true);
    final homeController = useScrollController();
    final exploareController = useScrollController();

    useEffect(() {
      void listener() {
        final activeController = selectedIndex.value == 0
            ? homeController
            : exploareController;
        if (!activeController.hasClients) return;
        if (activeController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (isVisible.value) isVisible.value = false;
        } else if (activeController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!isVisible.value) isVisible.value = true;
        }
      }

      homeController.addListener(listener);
      exploareController.addListener(listener);
      return () {
        homeController.removeListener(listener);
        exploareController.removeListener(listener);
      };
    }, [selectedIndex.value]);
    return ScrollProvider(
      homeController: homeController,
      exploreController: exploareController,
      child: Scaffold(
        key: scaffoldKey,
        extendBody: true,
        body: SafeArea(
          child: Stack(
            children: [
              child,
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedSlide(
                  offset: isVisible.value ? Offset.zero : const Offset(0, 1.8),
                  duration: const Duration(milliseconds: 300),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      BottomAppBar(
                        color: background,
                        height: 65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            NavigationIconLable(
                              icon: LucideIcons.layoutDashboard,
                              lable: 'Home',
                              selectedIndex: selectedIndex,
                              level: 0,
                              scrollController: homeController,
                            ),
                            NavigationIconLable(
                              icon: LucideIcons.search,
                              lable: 'Exploare',
                              selectedIndex: selectedIndex,
                              level: 1,
                              scrollController: exploareController,
                            ),
      
                            const SizedBox(width: 40),
      
                            NavigationIconLable(
                              icon: LucideIcons.bookmark,
                              lable: 'Saved',
                              selectedIndex: selectedIndex,
                              level: 2,
                            ),
                            NavigationIconLable(
                              icon: LucideIcons.settings,
                              lable: 'Setting',
                              selectedIndex: selectedIndex,
                              level: 3,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -20,
                        child: FloatingActionButton(
                          elevation: 4,
                          shape: const CircleBorder(),
                          onPressed: () => context.pushNamed('create'),
                          backgroundColor: primary,
                          child: const Icon(
                            LucideIcons.plus,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationIconLable extends StatelessWidget {
  final IconData icon;
  final String lable;
  final ValueNotifier<int> selectedIndex;
  final int level;
  final ScrollController? scrollController;
  const NavigationIconLable({
    super.key,
    required this.icon,
    required this.lable,
    required this.selectedIndex,
    required this.level,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (selectedIndex.value == level) {
            if (scrollController?.hasClients ?? false) {
              scrollController!.animateTo(
                0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
              );
            }
          } else {
            selectedIndex.value = level;
            switch (level) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/explore');
                break;
              case 2:
                context.go('/saved');
                break;
              case 3:
                context.go('/settings');
                break;
            }
          }
        },
        child: Column(
          children: [
            Icon(
              icon,
              color: selectedIndex.value == level
                  ? primary
                  : Colors.white.withValues(alpha: 0.7),
              size: 20,
            ),
            CustomTextStyle(
              text: lable,
              fontSize: 14,
              textColor: selectedIndex.value == level
                  ? primary
                  : Colors.white.withValues(alpha: 0.7),
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}