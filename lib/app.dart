import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather/di/dependency_injector.dart';
import 'package:weather/routers/app_router.gr.dart';

/// The App entry widget
class App extends StatelessWidget {
  final _router = AppRouter();

  /// The App entry widget constructor
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DependencyInjector(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: _router.defaultRouteParser(),
          routerDelegate: _router.delegate(),
          title: 'Weather',
          theme: ThemeData(
            colorScheme: const ColorScheme.dark(primary: Colors.white),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.dark,
          ),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      );
}
