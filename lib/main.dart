import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tech_node/app/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tech_node/core/constants/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('post_cache');
  await Hive.openBox('drafts_box');
  await Hive.openBox('recent_search');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: themeData,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US')],
      routerConfig: appRoutes,
      title: 'TechNode',
      debugShowCheckedModeBanner: false,
    );
  }
}
