import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/app/app.dart';
import 'package:tech_node/core/commen/widgets/view_author_profile.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';
import 'package:tech_node/data%20local/local%20Models/offline_blogs_model.dart';
import 'package:tech_node/view/Library/offline%20detail/view_offline_blog_detail.dart';
import 'package:tech_node/view/auth/forgot%20password/forgot_password.dart';
import 'package:tech_node/view/auth/forgot%20password/reset_password_page.dart';
import 'package:tech_node/view/auth/login%20page/login_page.dart';
import 'package:tech_node/view/auth/register%20page/register_page.dart';
import 'package:tech_node/view/create/create_page.dart';
import 'package:tech_node/view/detail%20post/detail_post_page.dart';
import 'package:tech_node/view/exploare/widgets/search%20page/search_page.dart';
import 'package:tech_node/view/followings/following_page.dart';
import 'package:tech_node/view/home/home_page.dart';
import 'package:tech_node/view/notification/notification_page.dart';
import 'package:tech_node/view/profile/profile_page.dart';
import 'package:tech_node/view/profile/widgets/edit_profile_page.dart';
import 'package:tech_node/view/Library/library_page.dart';
import 'package:tech_node/view/settings/setting_page.dart';

final GoRouter appRoutes = GoRouter(
  errorBuilder: (context, state) => Scaffold(
    body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Icon(LucideIcons.fileX, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const CustomTextStyle(
              text: "404",
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            const CustomTextStyle(
              text: "Oops! This page doesn't exist.",
              fontSize: 18,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: context.primary),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
              child: const CustomTextStyle(
                text: "Go Back",
                fontSize: 16,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  debugLogDiagnostics: true,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return AppMenu(child: child);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: FollowingPage()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/saved',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: LibraryPage()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: SettingPage()),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/detail-posts/:id/:blogUserId',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'none';
        final blogUserId = state.pathParameters['blogUserId'] ?? 'none';
        return DetailPostPage(postId: id, blogUserId: int.parse(blogUserId));
      },
    ),
    GoRoute(
      path: '/create_post',
      name: 'create',
      builder: (context, state) => const CreatePage(),
    ),
    GoRoute(
      path: '/search_page',
      name: 'search',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SearchPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/offline_detail/:blogId',
      name: 'offline_detail',
      builder: (context, state) {
        final blogId = state.pathParameters['blogId']!;
        final box = Hive.box<OfflineBlogsModel>('downloaded_articles');
        final blog = box.get(int.parse(blogId));
        return ViewOfflineBlogDetail(theBlog: blog!);
      },
    ),
    GoRoute(
      path: '/profile_page',
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
      routes: [
        GoRoute(
          path: 'edit_profile_page',
          name: 'edit_profile',
          builder: (context, state) => const EditProfilePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/login_page',
      name: 'login',
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          name: 'register',
          path: 'register_page',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          name: 'forgot_password',
          path: 'forgot_password_page',
          builder: (context, state) => const ForgotPassword(),
        ),
      ],
    ),
    GoRoute(
      path: '/notification_page',
      name: 'notification',
      builder: (context, state) => const NotificationPage(),
    ),
    GoRoute(
      path: '/author-profile/:id',
      name: 'authorProfile',
      builder: (context, state) {
        final authorID = state.pathParameters['id'] ?? '';
        return ViewAuthorProfile(authorID: authorID);
      },
    ),
    GoRoute(
      path: '/password-reset/:token',
      name: 'reset_password',
      builder: (context, state) {
        final token = state.pathParameters['token'];
        final email = state.uri.queryParameters['email'];
        return ResetPasswordPage(email: email ?? '', token: token ?? '');
      },
    ),
  ],
);
