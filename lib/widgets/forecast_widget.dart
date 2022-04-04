import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/extensions/double_extension.dart';
import 'package:weather/misc/decorators/weather_decoration.dart';
import 'package:weather/models/forecast.dart';
import 'package:weather/widgets/day_forecast_widget.dart';
import 'package:weather/widgets/now_widget.dart';
import 'package:weather/widgets/sensor_widget.dart';

/// A widget that shows the forecast for the next five days
class ForecastWidget extends StatelessWidget {
  /// The city name
  final String city;

  /// The forecast response coming from the API
  final List<Forecast> forecast;

  /// The onTap callback
  final void Function(
      String city, Forecast forecast, List<Forecast> dayForecast)? onTap;

  /// Constructor of the ForecastWidget
  const ForecastWidget({
    Key? key,
    required this.city,
    required this.forecast,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            image: WeatherDecoration(
                forecast.isNotEmpty ? forecast.first.weather.first.id : 0)),
        child: Column(
          children: [
            _now(),
            _details(),
            const Divider(
              color: Colors.white24,
              height: 0,
            ),
            _forecasts(context),
          ],
        ),
      );

  Widget _now() => Expanded(
        child: NowWidget(
          city: city,
          forecast: forecast.isNotEmpty ? forecast.first : null,
        ),
      );

  Widget _details() => Padding(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SensorWidget(
              icon: const FaIcon(FontAwesomeIcons.feather),
              value: '${forecast.first.main.pressure.round()} hPa',
            ),
            SensorWidget(
              icon: const FaIcon(FontAwesomeIcons.droplet),
              value: '${forecast.first.main.humidity.round()}%',
            ),
            if (forecast.first.wind != null)
              SensorWidget(
                icon: const FaIcon(FontAwesomeIcons.wind),
                value: '${forecast.first.wind?.speed.flatDouble} m/h',
              ),
            if (forecast.first.clouds != null)
              SensorWidget(
                icon: const FaIcon(FontAwesomeIcons.cloud),
                value: '${forecast.first.clouds?.all}%',
              ),
            if (forecast.first.snow != null)
              SensorWidget(
                icon: const FaIcon(FontAwesomeIcons.snowflake),
                value: '${forecast.first.snow?.threeHours.flatDouble} mm\u00B3',
              ),
            if (forecast.first.rain != null)
              SensorWidget(
                icon: const FaIcon(FontAwesomeIcons.cloudRain),
                value: '${forecast.first.rain?.threeHours.flatDouble} mm\u00B3',
              ),
            SensorWidget(
              icon: const FaIcon(FontAwesomeIcons.binoculars),
              value: '${(forecast.first.visibility / 1000).flatDouble} Km',
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      );

  Widget _forecasts(BuildContext context) => Card(
        margin: EdgeInsets.zero,
        shape: const Border(),
        color: Colors.transparent,
        child: Row(
          children: [
            if (forecast.isNotEmpty &&
                forecast.first.dt.day == DateTime.now().day &&
                forecast.first.dt.hour > 12)
              forecast.first,
            ...forecast.where((item) => item.dt.hour == 12)
          ]
              .take(5)
              .map(
                (forecast) => Expanded(
                  child: DayForecastWidget(
                    forecast: forecast,
                    onTap: () => onTap != null
                        ? onTap!(
                            city,
                            forecast,
                            this
                                .forecast
                                .where((element) =>
                                    element.dt.day == forecast.dt.day)
                                .toList(growable: false))
                        : null,
                  ),
                ),
              )
              .toList(growable: false),
        ),
      );
}
