import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:weather/cubits/search_cubit.dart';
import 'package:weather/widgets/error_widget.dart';

import '../utils/env_utils.dart';
import 'error_widget_test.mocks.dart';

@GenerateMocks([Logger])
void main() {
  Logger? logger;

  setUp(() {
    logger = MockLogger();
  });

  testWidgets('test not found error', (WidgetTester tester) async {
    const city = 'Bari';

    await tester.pumpWidget(
      EnvUtils.buildEnv(
        child: BlocProvider<SearchCubit>(
          create: (_) => SearchCubit(logger: logger!),
          child: ErrorWidget.notFound(city, onTap: null),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Uh oh!'), findsOneWidget);
    expect(find.text('I couldn\'t find the city you wanted: $city'),
        findsOneWidget);
  });

  testWidgets('test unauthorized error', (WidgetTester tester) async {
    await tester.pumpWidget(
      EnvUtils.buildEnv(
        child: BlocProvider<SearchCubit>(
          create: (_) => SearchCubit(logger: logger!),
          child: ErrorWidget.invalidAPIToken(onTap: null),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Uh oh!'), findsOneWidget);
    expect(find.text('The search cannot be fulfilled. Permission denied.'),
        findsOneWidget);
  });

  testWidgets('test no internet error', (WidgetTester tester) async {
    await tester.pumpWidget(
      EnvUtils.buildEnv(
        child: BlocProvider<SearchCubit>(
          create: (_) => SearchCubit(logger: logger!),
          child: ErrorWidget.noInternet(onTap: null),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Uh oh!'), findsOneWidget);
    expect(
        find.text('Can\'t get the information without an internet connection.'),
        findsOneWidget);
  });

  testWidgets('test empty city error', (WidgetTester tester) async {
    await tester.pumpWidget(
      EnvUtils.buildEnv(
        child: BlocProvider<SearchCubit>(
          create: (_) => SearchCubit(logger: logger!),
          child: ErrorWidget.emptyCity(onTap: null),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Uh oh!'), findsOneWidget);
    expect(find.text('I can\'t search for a city that you didn\'t write.'),
        findsOneWidget);
  });

  testWidgets('test generic error', (WidgetTester tester) async {
    await tester.pumpWidget(
      EnvUtils.buildEnv(
        child: BlocProvider<SearchCubit>(
          create: (_) => SearchCubit(logger: logger!),
          child: const ErrorWidget(onTap: null),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Uh oh!'), findsOneWidget);
    expect(find.text('A generic error has occurred.'), findsOneWidget);
  });
}
