import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_button.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/view/create/widgets/guest/features_grid.dart';
import 'package:tech_node/view/create/widgets/guest/final_continue_login.dart';
import 'package:tech_node/view/create/widgets/guest/user_and_author_stats.dart';

class CreateBlogGuestPage extends StatefulWidget {
  const CreateBlogGuestPage({super.key});

  @override
  State<CreateBlogGuestPage> createState() => CreateBlogGuestPageState();
}

class CreateBlogGuestPageState extends State<CreateBlogGuestPage>
    with TickerProviderStateMixin {
  late final AnimationController _entryCtrl;
  late final AnimationController _shimmerCtrl;
  late final AnimationController _floatCtrl;
  late final AnimationController _typeCtrl;

  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _heroSlideAnim;
  late final Animation<double> _typeAnim;

  // Typewriter state
  final String _typewriterText = 'Start writing your story...';
  int _typewriterIndex = 0;

  @override
  void initState() {
    super.initState();

    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _typeCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _typewriterText.length * 80),
    );

    _fadeAnim = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut);
    _heroSlideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic));

    _typeAnim = CurvedAnimation(parent: _typeCtrl, curve: Curves.linear);

    _typeAnim.addListener(() {
      final idx = (_typeAnim.value * _typewriterText.length).round();
      if (idx != _typewriterIndex && mounted) {
        setState(() => _typewriterIndex = idx);
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _entryCtrl.forward();
        _typeCtrl.forward();
      }
    });
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _shimmerCtrl.dispose();
    _floatCtrl.dispose();
    _typeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _heroSlideAnim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLockedOverlayCard(),
                      const FeaturesGrid(),
                      const UserAndAuthorStats(),
                      const FinalContinueLogin(),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: background,
      expandedHeight: 47,
      collapsedHeight: 45,
      toolbarHeight: 45,
      leading: null,
      surfaceTintColor: background,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        expandedTitleScale: 1.0,
        title: Row(
          children: [
            IconButton(
              highlightColor: background,
              splashColor: background,
              onPressed: () {
                if (!context.mounted) return;
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/home');
                }
              },
              icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
            ),
            const CustomTextStyle(
              text: 'Create Post',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.amber.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_outline_rounded, size: 11),
                  SizedBox(width: 5),
                  CustomTextStyle(
                    text: 'Sign in required',
                    fontSize: 11,
                    letterSpacing: 0.2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedOverlayCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: card),
      ),
      child: Column(
        children: [
          _buildTypewriterPreview(),
          const SizedBox(height: 24),

          const CustomTextStyle(
            text: 'Your words deserve\na beautiful home.',
            textAlign: TextAlign.center,
            fontFamily: 'Georgia',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),

          const SizedBox(height: 12),

          const CustomTextStyle(
            text:
                'Sign in to access the full editor — rich formatting, '
                'cover images, tags, drafts, and instant publishing to '
                'thousands of readers.',
            textAlign: TextAlign.center,
            textColor: Colors.white54,
            fontSize: 14,
          ),
          const SizedBox(height: 28),
          CustomButton(
            height: 52,
            onPressed: () {
              context.push('/login_page');
            },
            label: const Row(
              mainAxisSize: .min,
              children: [
                CustomTextStyle(
                  text: 'Sign in to Start Writing',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                ),
                SizedBox(width: 8),
                Icon(LucideIcons.arrowRight, size: 18),
              ],
            ),
          ),
          const SizedBox(height: 14),
          TextButton(
            onPressed: () {
              context.push('/login_page/register_page');
            },
            style: TextButton.styleFrom(
              foregroundColor: background,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13, color: Colors.white),
                children: [
                  const TextSpan(text: "Don't have an account? "),
                  TextSpan(
                    text: 'Create a free account→',
                    style: TextStyle(
                      color: context.primary,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: context.primary.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypewriterPreview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: background),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _shimmerCtrl,
            builder: (_, _) {
              final blink = (_shimmerCtrl.value * 2).floor() % 2 == 0;
              return AnimatedOpacity(
                opacity: blink ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: 2,
                  height: 18,
                  decoration: BoxDecoration(
                    color: card,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomTextStyle(
              text: _typewriterText.substring(0, _typewriterIndex),

              fontSize: 15,
              textColor: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
