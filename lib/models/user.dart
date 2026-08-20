import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppUser {
  final String fullName;
  final String email;
  final String password;
  final bool notificationsEnabled;

  const AppUser({
    required this.fullName,
    required this.email,
    required this.password,
    this.notificationsEnabled = true,
  });

  AppUser copyWith({
    String? fullName,
    String? email,
    String? password,
    bool? notificationsEnabled,
  }) {
    return AppUser(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'password': password,
    'notificationsEnabled': notificationsEnabled,
  };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    fullName: json['fullName'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
  );
}

/// Small local "backend" backed by shared_preferences so accounts
/// survive an app restart. Not encrypted, not a real auth system —
/// just enough persistence to make Patrol flows (create account,
/// close app, log back in) meaningful to test.
class UserStore {
  UserStore._internal();
  static final UserStore instance = UserStore._internal();

  static const _storageKey = 'patrol_practice_users';

  final List<AppUser> _users = [];
  bool _loaded = false;

  List<AppUser> get users => List.unmodifiable(_users);

  /// Must be awaited once before the app is used (e.g. in `main()`).
  Future<void> init() async {
    if (_loaded) return;

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw == null) {
      // First run: seed with one known account so login can be
      // tested immediately without signing up first.
      _users.add(
        const AppUser(
          fullName: 'Test User',
          email: 'test@example.com',
          password: 'password123',
        ),
      );
      await _persist();
    } else {
      final decoded = jsonDecode(raw) as List<dynamic>;
      _users.addAll(
        decoded.map((e) => AppUser.fromJson(e as Map<String, dynamic>)),
      );
    }

    _loaded = true;
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_users.map((u) => u.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  bool emailExists(String email) =>
      _users.any((u) => u.email.toLowerCase() == email.toLowerCase());

  Future<void> addUser(AppUser user) async {
    _users.add(user);
    await _persist();
  }

  AppUser? login(String email, String password) {
    try {
      return _users.firstWhere(
        (u) =>
            u.email.toLowerCase() == email.toLowerCase() &&
            u.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  /// Wipes all stored accounts. Handy to call from a Patrol test's
  /// setUp so each test run starts clean.
  Future<void> clearAll() async {
    _users.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    _loaded = false;
  }
}
