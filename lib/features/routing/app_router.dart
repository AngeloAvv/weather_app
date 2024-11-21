import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:weather/models/forecast/forecast.dart';
import 'package:weather/pages/forecast/forecast_page.dart';
import 'package:weather/pages/main/main_page.dart';

part 'app_router.gr.dart';

/// The AppRouter placeholder
@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: MainRoute.page,
    ),
    AutoRoute(page: ForecastRoute.page),
  ];
}