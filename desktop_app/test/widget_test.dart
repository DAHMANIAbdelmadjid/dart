// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:desktop_app/main.dart';

void main() {
  testWidgets('Hardware Store App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed
    expect(find.text('Hardware Shop Management'), findsOneWidget);
    
    // Verify that the navigation rail is displayed
    expect(find.byType(NavigationRail), findsOneWidget);
    
    // Verify that the home page is the initial page
    expect(find.text('Home'), findsOneWidget);
  });
}
