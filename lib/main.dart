import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tech_node/app/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tech_node/core/theme/provider/theme_color_notifier.dart';
import 'package:tech_node/core/constants/themes.dart';

import 'data local/local Models/offline_blogs_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.registerAdapter(OfflineBlogsModelAdapter());
  final dire = await getApplicationDocumentsDirectory();
  Hive.init(dire.path);
  await Future.wait([
    Hive.openBox('post_cache'),
    Hive.openBox('drafts_box'),
    Hive.openBox('recent_search'),
    Hive.openBox('user_profile'),
    Hive.openBox<OfflineBlogsModel>('downloaded_articles'),
    Hive.openBox('settings'),
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dynamicPrimary = ref.watch(themeColorProvider);
    return MaterialApp.router(
      theme: getAppTheme(dynamicPrimary),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US')],
      routerConfig: appRoutes,
      title: 'BlogNode',
      debugShowCheckedModeBanner: false,
    );
  }
}
