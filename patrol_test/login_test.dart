import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_example/main.dart';
import 'package:flutter/material.dart';

void main() {
  patrolTest('login with valid credentials', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('password123');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    expect(find.text('Patrol Practice'), findsOneWidget);
  });

  patrolTest('Login with invalid credentials', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('wrongpassword');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    expect(find.text('Invalid email or password'), findsOneWidget);
  });

  patrolTest('Login with empty email field', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#passwordField).enterText('password123');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    expect(find.text('Email is required'), findsOneWidget);
  });

  patrolTest('Login with empty password field', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#emailField).enterText('test@example.com');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    expect(find.text('Password is required'), findsOneWidget);
  });

  patrolTest('validate if password is case sensitive', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('PASSWORD123');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    expect(find.text('Invalid email or password'), findsOneWidget);
  });

  patrolTest('Validate Logout', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('password123');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    expect(find.text('Patrol Practice'), findsOneWidget);
    await $(#logoutButton).tap();
    expect(find.text('Log out'), findsOneWidget);
    await $(#confirmLogoutButton).tap();

    await $.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
  });
}
