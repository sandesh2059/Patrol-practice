import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_example/main.dart';
import 'package:flutter/material.dart';

void main() {
  patrolTest('home screen test', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('password123');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    expect(find.text('Patrol Practice'), findsOneWidget);
  });
}
