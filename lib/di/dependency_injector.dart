import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pine/pine.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:weather/repositories/mappers/city_mapper.dart';
import 'package:weather/repositories/mappers/forecast_mapper.dart';
import 'package:weather/services/network/rest_client.dart';
import 'package:weather/repositories/weather_repository.dart';

part 'providers.dart';
part 'repositories.dart';

/// A widget to inject multiple providers and repositories in the widget tree
class DependencyInjector extends StatelessWidget {
  /// The child widget
  final Widget child;

  /// DependencyInjector constructor
  const DependencyInjector({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
    providers: _providers,
    repositories: _repositories,
    child: child,
  );
}
