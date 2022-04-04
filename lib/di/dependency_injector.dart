import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:weather/network/rest_client.dart';
import 'package:weather/repositories/weather_repository.dart';

part 'providers.dart';
part 'repositories.dart';

/// A widget to inject multiple providers and repositories in the widget tree
class DependencyInjector extends StatelessWidget {
  /// The child widget
  final Widget child;

  /// DependencyInjector constructor
  const DependencyInjector({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _Providers(
        child: _Repositories(
          child: child,
        ),
      );
}
