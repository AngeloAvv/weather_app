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
  const SensorWidget({
    super.key,
    this.title,
    this.icon,
    this.landscape = false,
    required this.value,
  }) : assert(title != null || icon != null);

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
  Widget build(BuildContext context) => switch (landscape) {
        true => _landscapeWidget(context),
        false => _portraitWidget(context),
      };

  Widget _portraitWidget(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ??
              Text(
                title!,
                key: const Key('sensor_title'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
          Container(height: 8),
          Text(
            value,
            key: const Key('sensor_value'),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      );

  Widget _landscapeWidget(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ??
              Text(
                title!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color),
              ),
          Container(width: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      );
}
