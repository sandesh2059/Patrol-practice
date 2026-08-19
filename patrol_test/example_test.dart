import 'package:patrol/patrol.dart';

void main() {
  patrolTest('Login validation', ($) async {
    // Find the email field and enter an invalid email
    await $(#email).enterText('wrong@email.com');

    // Find the password field and enter an incorrect password
    await $(#password).enterText('wrongpassword');

    // Tap the Login button
    await $('Login').tap();

    // Verify that the validation message appears
    await $('Invalid email or password').waitUntilVisible();
  });
}
