// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/app.dart';

void main() {
  testWidgets('test Welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    await tester.pump();

    expect(find.byKey(const Key('txt_welcome')), findsOneWidget);
    expect(find.byKey(const Key('txt_search')), findsOneWidget);
    expect(find.byKey(const Key('btn_action_search')), findsOneWidget);
  });

  testWidgets('test search button disappear', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    await tester.pump();

    final searchBtn = find.byKey(const Key('btn_action_search'));

    expect(find.byKey(const Key('txt_welcome')), findsOneWidget);
    expect(find.byKey(const Key('txt_search')), findsOneWidget);
    expect(searchBtn, findsOneWidget);

    await tester.tap(searchBtn);
    await tester.pump();

    expect(searchBtn, findsNothing);
  });
}
