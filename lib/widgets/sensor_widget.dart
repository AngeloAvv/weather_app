import 'package:flutter/material.dart';

/// A widget used to show a particular measurement detail (temperature, humidity, etc)
class SensorWidget extends StatelessWidget {
  /// Identifies if the device is in landscape state
  final bool landscape;

  /// The optional icon to identify the measurement
  final Widget? icon;

  /// The title of the measurement
  final String? title;

  /// The value of the measurement
  final String value;

  /// The SensorWidget constructor
  SensorWidget({
    Key? key,
    this.title,
    this.icon,
    this.landscape = false,
    required this.value,
  }) : super(key: key) {
    assert(title != null || icon != null);
  }

  /// The factory method to create a sensor widget in landscape
  factory SensorWidget.landscape({
    Key? key,
    String? title,
    Widget? icon,
    required String value,
  }) =>
      SensorWidget(
        key: key,
        title: title,
        icon: icon,
        value: value,
        landscape: true,
      );

  @override
  Widget build(BuildContext context) =>
      landscape ? _landscapeWidget(context) : _portraitWidget(context);

  Widget _portraitWidget(BuildContext context) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ??
                Text(
                  title!,
                  key: const Key('sensor_title'),
                  style: Theme.of(context).textTheme.caption,
                ),
            Container(height: 8),
            Text(
              value,
              key: const Key('sensor_value'),
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ]);

  Widget _landscapeWidget(BuildContext context) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ??
                Text(
                  title!,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Theme.of(context).textTheme.caption?.color),
                ),
            Container(width: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ]);
}
