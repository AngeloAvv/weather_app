import 'package:auto_route/auto_route.dart';
import 'package:weather/pages/forecast_page.dart';
import 'package:weather/pages/main_page.dart';

/// The AppRouter placeholder
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  preferRelativeImports: false,
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      page: MainPage,
    ),
    AutoRoute(page: ForecastPage),
  ],
)
class $AppRouter {}
