import 'package:flutter_test/flutter_test.dart';
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
}
