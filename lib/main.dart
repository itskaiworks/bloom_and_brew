import 'package:flutter/material.dart';

import 'pages/home_screen.dart';
import 'pages/login_screen.dart';
import 'pages/signup_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const BloomAndBrewApp());

class BloomAndBrewApp extends StatelessWidget {
  const BloomAndBrewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Bloom & Brew',
          debugShowCheckedModeBanner: false,

          // Applies the currently selected light or dark theme
          themeMode: mode,
          theme: buildAppTheme(AppColors.light, Brightness.light),
          darkTheme: buildAppTheme(AppColors.dark, Brightness.dark),

          // Defines the app's named navigation routes
          initialRoute: '/', // Sets the login screen as the starting page
          routes: {
            '/': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
            '/signup': (context) => const SignUpScreen(),
          },
        );
      },
    );
  }
}
