import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:patrol_example/main.dart';

void main() {
  testWidgets('App launches and shows the login screen', (tester) async {
    await tester.pumpWidget(const PatrolPracticeApp());

    // The app shows a loading spinner while UserStore reads from
    // shared_preferences, then settles on the login screen.
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.byKey(const Key('emailField')), findsOneWidget);
    expect(find.byKey(const Key('passwordField')), findsOneWidget);
  });
}
