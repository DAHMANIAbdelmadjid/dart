// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_auth/main.dart';

void main() {
  testWidgets('Staff form smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the form title is displayed
    expect(find.text('Add a New Staff'), findsOneWidget);

    // Verify that form fields are present
    expect(find.byType(TextFormField), findsWidgets);
    expect(find.byType(DropdownButtonFormField), findsWidgets);
    
    // Verify that the submit button is present
    expect(find.text('Ajoutes une voiture'), findsOneWidget);
  });
}
