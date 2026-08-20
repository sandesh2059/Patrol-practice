import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_example/main.dart';

void main() {
  patrolTest('create account with valid credentials', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#goToCreateAccount).tap();
    await $(#nameField).enterText('sandesh chy');
    await $(#signupEmailField).enterText('sandeshchy@example.com');
    await $(#signupPasswordField).enterText('Sandesh@12');
    await $(#confirmPasswordField).enterText('Sandesh@12');
    await $(#acceptTermsCheckbox).tap();
    await $(#createAccountButton).tap();
    expect(find.text('Account created! You can now log in.'), findsOneWidget);
    await $.pumpAndSettle();
  });

  patrolTest('create account without filling fullname field', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#goToCreateAccount).tap();
    await $(#signupEmailField).enterText('sandeshchy@example.com');
    await $(#signupPasswordField).enterText('Sandesh@12');
    await $(#confirmPasswordField).enterText('Sandesh@12');
    await $(#acceptTermsCheckbox).tap();
    await $(#createAccountButton).tap();
    expect(find.text('Name is required'), findsOneWidget);
    await $.pumpAndSettle();
  });

  patrolTest('create account without filling email field', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#goToCreateAccount).tap();
    await $(#nameField).enterText('sandesh chy');
    await $(#signupPasswordField).enterText('Sandesh@12');
    await $(#confirmPasswordField).enterText('Sandesh@12');
    await $(#acceptTermsCheckbox).tap();
    await $(#createAccountButton).tap();
    expect(find.text('Email is required'), findsOneWidget);
    await $.pumpAndSettle();
  });

  patrolTest('create account without filling password field', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#goToCreateAccount).tap();
    await $(#nameField).enterText('sandesh chy');
    await $(#signupEmailField).enterText('sandeshchy@example.com');
    await $(#confirmPasswordField).enterText('Sandesh@12');
    await $(#acceptTermsCheckbox).tap();
    await $(#createAccountButton).tap();
    expect(find.text('Password is required'), findsOneWidget);
    await $.pumpAndSettle();
  });

  patrolTest('create account without filling confirm password field', (
    $,
  ) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#goToCreateAccount).tap();
    await $(#nameField).enterText('sandesh chy');
    await $(#signupEmailField).enterText('sandeshchy@example.com');
    await $(#signupPasswordField).enterText('Sandesh@12');
    await $(#acceptTermsCheckbox).tap();
    await $(#createAccountButton).tap();
    expect(find.text('Passwords do not match'), findsOneWidget);
    await $.pumpAndSettle();
  });

  patrolTest('create account without accepting terms and conditions', (
    $,
  ) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#goToCreateAccount).tap();
    await $(#nameField).enterText('sandesh chy');
    await $(#signupEmailField).enterText('sandeshchy@example.com');
    await $(#signupPasswordField).enterText('Sandesh@12');
    await $(#confirmPasswordField).enterText('Sandesh@12');
    await $(#createAccountButton).tap();
    expect(find.text('You must accept the terms to continue'), findsOneWidget);
    await $.pumpAndSettle();
  });

  patrolTest('create account with invalid email', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#goToCreateAccount).tap();
    await $(#nameField).enterText('sandesh chy');
    await $(#signupEmailField).enterText('sandeshchyexample.com');
    await $(#signupPasswordField).enterText('Sandesh@12');
    await $(#confirmPasswordField).enterText('Sandesh@12');
    await $(#acceptTermsCheckbox).tap();
    await $(#createAccountButton).tap();
    expect(find.text('Enter a valid email'), findsOneWidget);
    await $.pumpAndSettle();
  });

  patrolTest('create account with password less than 6 characters', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#goToCreateAccount).tap();
    await $(#nameField).enterText('sandesh chy');
    await $(#signupEmailField).enterText('sandeshchy@example.com');
    await $(#signupPasswordField).enterText('Sande');
    await $(#confirmPasswordField).enterText('Sande');
    await $(#acceptTermsCheckbox).tap();
    await $(#createAccountButton).tap();
    expect(find.text('Minimum 6 characters'), findsOneWidget);
    await $.pumpAndSettle();
  });

  patrolTest('check if password masking is working', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#goToCreateAccount).tap();

    await $(#signupPasswordField).enterText('mySecret123');
    await $(#confirmPasswordField).enterText('mySecret123');

    EditableText getEditableText(String key) {
      return $.tester.widget<EditableText>(
        find.descendant(
          of: find.byKey(Key(key)),
          matching: find.byType(EditableText),
        ),
      );
    }

    expect(getEditableText('signupPasswordField').obscureText, isTrue);
    expect(getEditableText('confirmPasswordField').obscureText, isTrue);
  });
}
