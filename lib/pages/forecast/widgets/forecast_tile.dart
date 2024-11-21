import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/forecast/forecast.dart';
import 'package:weather/widgets/owm_icon.dart';

/// Widget tile that shows a particular weather condition
class ForecastTile extends StatelessWidget {
  /// A particular forecast
  final Forecast forecast;

  /// The ForecastItem constructor
  const ForecastTile(
    this.forecast, {
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat.Hm(Localizations.localeOf(context).languageCode)
                .format(forecast.dt))
          ],
        ),
        title: Row(
          children: [
            SizedBox(
              height: 60,
              child: forecast.weather.isNotEmpty
                  ? OpenWeatherMapIcon(forecast.weather.first.icon)
                  : Container(),
            ),
            if (forecast.weather.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    forecast.weather.first.description,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
          ],
        ),
        trailing: Text('${forecast.main.temp.round()}°C'),
      );
}
