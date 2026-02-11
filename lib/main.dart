import 'package:espritacademy/screeens/components/splash_screen.dart';
import 'package:espritacademy/screens/reset_password_screen.dart';
import 'package:espritacademy/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Esprit Academy',
      theme: AppTheme.lightTheme,

      // ✅ Use initialRoute + getPages (do NOT set `home:`)
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const Splash_Animated(),
        ),
        GetPage(
          name: '/ResetPasswordPage',
          page: () => ResetPasswordPage(
            token: Get.parameters['token'], // <-- token read from URL
          ),
        ),
      ],

      // (Optional) Unknown routes fallback
      unknownRoute: GetPage(
        name: '/404',
        page: () => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      ),
    );
  }
}