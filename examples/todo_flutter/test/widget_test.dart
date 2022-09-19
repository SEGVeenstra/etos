// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_flutter/main.dart';

void main() {
  testWidgets('Login and Logout test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that we start on the login page
    expect(find.text('Login'), findsOneWidget);

    // Tap the login button
    await tester.tap(find.byKey(const ValueKey('login_button')));
    await tester.pump();

    // Verify that we no longer have a login button
    expect(find.text('Login'), findsNothing);

    // Verify that there is a logout button
    expect(find.widgetWithIcon(IconButton, Icons.logout), findsOneWidget);

    // Tap the logout button
    await tester.tap(find.byKey(const ValueKey('logout_button')));
    await tester.pump();

    // Verify that we returned to the login page
    expect(find.text('Login'), findsOneWidget);
  });
}
