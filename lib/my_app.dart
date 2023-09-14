import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app99/config/custom_theme.dart';
import 'package:shopping_app99/lang/translation_service.dart';
import 'config/routers.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = Hive.box('myBox');

  String? isLogin = '0';
  @override
  void initState() {
    super.initState();
    getCheckLogin();
  }

  dynamic getCheckLogin() {
    isLogin = box.get('is_login');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return GetMaterialApp(
      title: "Shopping App",
      translations: TranslationService(),
      locale: box.get('currentLang') == 'en'
          ? const Locale('en', 'US')
          : const Locale('lo', 'LO'),
      fallbackLocale: const Locale('lo', 'LO'),
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      initialRoute: isLogin == "1" ? '/home' : '/',
      getPages: appRoutes(),
    );
  }
}
