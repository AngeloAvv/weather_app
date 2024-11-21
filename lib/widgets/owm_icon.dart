import 'package:flutter/material.dart';

/// A widget to show the proper icon according to the weather status
class OpenWeatherMapIcon extends StatelessWidget {
  /// The icon name
  final String icon;

  /// Constructor of the OpenWeatherMapIcon widget
  const OpenWeatherMapIcon(this.icon, {super.key});

  @override
  Widget build(BuildContext context) =>
      Image.network('http://openweathermap.org/img/wn/$icon@2x.png');
}
