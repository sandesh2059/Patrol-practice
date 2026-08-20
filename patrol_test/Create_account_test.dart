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
    await $.pumpAndSettle();
  });
}
