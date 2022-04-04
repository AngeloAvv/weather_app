import 'package:flutter/material.dart';

/// A custom decorator to show the right image in the forecast page
class WeatherDecoration extends DecorationImage {
  /// The decoration id
  final int id;

  /// WeatherDecoration constructor
  WeatherDecoration(
    this.id, {
    double opacity = 0.6,
  }) : super(
          image: WeatherDecoration._mapAssetImage(id),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(opacity),
            BlendMode.dstATop,
          ),
          fit: BoxFit.cover,
        );

  /// Factory method to create a weather decoration for a clear day
  factory WeatherDecoration.clearDay() => WeatherDecoration(0);

  /// Factory method to create a weather decoration for a rainy day
  factory WeatherDecoration.rain() => WeatherDecoration(300);

  static AssetImage _mapAssetImage(int id) {
    String name = 'clearday';
    if (id >= 200 && id <= 232) {
      name = 'thunder';
    } else if (id >= 300 && id <= 321 || id >= 500 && id <= 531) {
      name = 'rain';
    } else if (id >= 600 && id <= 622) {
      name = 'snow';
    } else if (id >= 700 && id <= 781) {
      name = 'fog';
    } else if (id >= 801 && id <= 804) {
      name = 'cloud';
    }

    return AssetImage("assets/bg/$name.png");
  }
}
