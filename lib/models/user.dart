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
}

/// Extremely small in-memory "backend" so the demo app has state to
/// interact with. Good enough for Patrol tests that just need to
/// create an account then log in with it.
class UserStore {
  UserStore._internal();
  static final UserStore instance = UserStore._internal();

  final List<AppUser> _users = [
    const AppUser(
      fullName: 'Test User',
      email: 'test@example.com',
      password: 'password123',
    ),
  ];

  List<AppUser> get users => List.unmodifiable(_users);

  bool emailExists(String email) =>
      _users.any((u) => u.email.toLowerCase() == email.toLowerCase());

  void addUser(AppUser user) => _users.add(user);

  AppUser? login(String email, String password) {
    try {
      return _users.firstWhere(
        (u) => u.email.toLowerCase() == email.toLowerCase() && u.password == password,
      );
    } catch (_) {
      return null;
    }
  }
}
