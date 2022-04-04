import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/widgets/sensor_widget.dart';

import '../utils/env_utils.dart';

void main() {
  testWidgets('test find title and value', (WidgetTester tester) async {
    await tester.pumpWidget(
      EnvUtils.buildEnv(
        child: SensorWidget(
          title: 'Some title',
          value: 'Some value',
        ),
      ),
    );

    await tester.pump();

    expect(find.byKey(const Key('sensor_title')), findsOneWidget);
    expect(find.byKey(const Key('sensor_value')), findsOneWidget);
  });

  testWidgets('test find icon and value', (WidgetTester tester) async {
    await tester.pumpWidget(
      EnvUtils.buildEnv(
        child: SensorWidget(
          icon: const Icon(Icons.close),
          value: 'Some value',
        ),
      ),
    );

    await tester.pump();

    expect(find.byKey(const Key('sensor_title')), findsNothing);
    expect(find.byKey(const Key('sensor_value')), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('test portrait', (WidgetTester tester) async {
    await tester.pumpWidget(
      EnvUtils.buildEnv(
        child: SensorWidget(
          title: 'Some title',
          value: 'Some value',
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Row), findsNothing);
  });

  testWidgets('test landscape', (WidgetTester tester) async {
    await tester.pumpWidget(
      EnvUtils.buildEnv(
        child: SensorWidget(
          title: 'Some title',
          value: 'Some value',
          landscape: true,
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Column), findsNothing);
  });
}
