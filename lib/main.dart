import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/create_account_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const PatrolPracticeApp());
}

class PatrolPracticeApp extends StatelessWidget {
  const PatrolPracticeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patrol Practice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      // Named routes: handy for Patrol's `$.tap(find.text(...))` +
      // `Navigator` based navigation tests.
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
      },
    );
  }
}
