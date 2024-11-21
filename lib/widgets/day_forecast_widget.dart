import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/forecast/forecast.dart';
import 'package:weather/widgets/owm_icon.dart';

/// A widget to show a single forecast day
class DayForecastWidget extends StatelessWidget {
  /// The weather forecast
  final Forecast forecast;

  /// The callback function to back-propagate the onTap event on this very widget
  final GestureTapCallback? onTap;

  /// The DayForecastWidget constructor
  const DayForecastWidget(
    this.forecast, {
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat.MEd(Localizations.localeOf(context).languageCode)
                    .format(forecast.dt),
              ),
              if (forecast.weather.isNotEmpty)
                SizedBox.fromSize(
                  size: const Size(48, 48),
                  child: OpenWeatherMapIcon(forecast.weather.first.icon),
                ),
              Text('${forecast.main.temp.round()}°C'),
            ],
          ),
        ),
      );
}
