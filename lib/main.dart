import 'package:flutter/material.dart';

import 'models/user.dart';
import 'screens/login_screen.dart';
import 'screens/create_account_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  // Needed because we call into shared_preferences (platform channels)
  // before runApp.
  WidgetsFlutterBinding.ensureInitialized();
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
      // Boots by loading persisted users, then hands off to the
      // named-route flow below.
      home: const _StartupGate(),
      onGenerateRoute: (settings) {
        final builders = <String, WidgetBuilder>{
          LoginScreen.routeName: (context) => const LoginScreen(),
          CreateAccountScreen.routeName: (context) =>
              const CreateAccountScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen(),
        };
        final builder = builders[settings.name];
        if (builder == null) {
          return null;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

/// Waits for `UserStore.instance.init()` (reading shared_preferences)
/// before showing the login screen, so the persisted account list is
/// guaranteed to be loaded before anyone can log in or sign up.
class _StartupGate extends StatefulWidget {
  const _StartupGate();

  @override
  State<_StartupGate> createState() => _StartupGateState();
}

class _StartupGateState extends State<_StartupGate> {
  late final Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = UserStore.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              key: Key('startupLoadingIndicator'),
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const LoginScreen();
      },
    );
  }
}
