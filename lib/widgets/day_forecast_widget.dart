import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/forecast.dart';
import 'package:weather/widgets/owm_icon.dart';

/// A widget to show a single forecast day
class DayForecastWidget extends StatelessWidget {
  /// The weather forecast
  final Forecast forecast;

  /// The callback function to back-propagate the onTap event on this very widget
  final VoidCallback? onTap;

  /// The DayForecastWidget constructor
  const DayForecastWidget({
    Key? key,
    required this.forecast,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        child: Padding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _date(context),
              _icon(),
              _temperature(context),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onTap: onTap,
      );

  Widget _date(BuildContext context) => Text(
        DateFormat.MEd(Localizations.localeOf(context).languageCode)
            .format(forecast.dt),
      );

  Widget _icon() => SizedBox.fromSize(
        child: forecast.weather.isNotEmpty
            ? OpenWeatherMapIcon(forecast.weather.first.icon)
            : Container(),
        size: const Size(48, 48),
      );

  Widget _temperature(BuildContext context) =>
      Text('${forecast.main.temp.round()}°C');
}
