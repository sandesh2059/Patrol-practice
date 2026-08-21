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

  patrolTest('counter increment test', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('password123');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    await $(#counterValue).waitUntilVisible();
    expect(find.text('0'), findsOneWidget);
    await $(#incrementButton).tap();
    await $(#incrementButton).tap();
    await $(#incrementButton).tap();
    await $.pumpAndSettle();
    expect(find.text('3'), findsOneWidget);
  });

  patrolTest('counter decrement test', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('password123');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    await $(#counterValue).waitUntilVisible();
    expect(find.text('0'), findsOneWidget);
    await $(#decrementButton).tap();
    await $(#decrementButton).tap();
    await $(#decrementButton).tap();
    await $.pumpAndSettle();
    expect(find.text('-3'), findsOneWidget);
  });

  patrolTest('First increment then decrement test', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('password123');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    await $(#counterValue).waitUntilVisible();
    expect(find.text('0'), findsOneWidget);
    await $(#incrementButton).tap();
    expect(find.text('1'), findsOneWidget);
    await $(#decrementButton).tap();
    expect(find.text('0'), findsOneWidget);
    await $(#decrementButton).tap();
    await $.pumpAndSettle();
    expect(find.text('-1'), findsOneWidget);
  });

  patrolTest('Add new task', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('password123');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    await $(#counterValue).waitUntilVisible();
    await $(#tasksTabButton).tap();
    await $(#newTaskField).waitUntilVisible();
    await $(#newTaskField).enterText('write new task field test');
    await $(#addTaskButton).tap();
    await $.pumpAndSettle();
    expect(find.text('write new task field test'), findsOneWidget);
  });

  patrolTest('add multiple task ', ($) async {
    await $.pumpWidgetAndSettle(const PatrolPracticeApp());
    await $(#loginTitle).waitUntilVisible();
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('password123');
    await $(#loginButton).tap();
    await $.pumpAndSettle();
    await $(#counterValue).waitUntilVisible();
    await $(#tasksTabButton).tap();
    await $(#newTaskField).waitUntilVisible();
    await $(#newTaskField).enterText('write new task field test1');
    await $(#addTaskButton).tap();
    await $(#newTaskField).waitUntilVisible();
    await $(#newTaskField).enterText('write new task field test2');
    await $(#addTaskButton).tap();
    await $.pumpAndSettle();
    await $(#newTaskField).waitUntilVisible();
    await $(#newTaskField).enterText('write new task field test3');
    await $(#addTaskButton).tap();
    await $.pumpAndSettle();
    expect(find.text('write new task field test1'), findsOneWidget);
    expect(find.text('write new task field test2'), findsOneWidget);
    expect(find.text('write new task field test3'), findsOneWidget);
  });
}
