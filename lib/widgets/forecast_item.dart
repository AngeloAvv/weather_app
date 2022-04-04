import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/forecast.dart';
import 'package:weather/widgets/owm_icon.dart';

/// Widget tile that shows a particular weather condition
class ForecastItem extends StatelessWidget {
  /// A particular forecast
  final Forecast forecast;

  /// The ForecastItem constructor
  const ForecastItem({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
      leading: Column(
        children: [
          Text(DateFormat.Hm(Localizations.localeOf(context).languageCode)
              .format(forecast.dt))
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      title: _titleWidget(context),
      trailing: Text('${forecast.main.temp.round()}°C'));

  Widget _titleWidget(BuildContext context) => Row(
        children: [
          SizedBox(
            child: forecast.weather.isNotEmpty
                ? OpenWeatherMapIcon(forecast.weather.first.icon)
                : Container(),
            height: 60,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _title(context),
            ],
          ),
        ],
      );

  Widget _title(BuildContext context) => forecast.weather.isNotEmpty
      ? Text(
          forecast.weather.first.description,
          style: Theme.of(context).textTheme.subtitle1,
        )
      : Container();
}
