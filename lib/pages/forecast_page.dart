import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:weather/misc/decorators/weather_decoration.dart';
import 'package:weather/models/forecast.dart';
import 'package:weather/widgets/forecast_item.dart';
import 'package:weather/widgets/owm_icon.dart';

/// The forecast page to show a single forecast
class ForecastPage extends StatelessWidget {
  /// The single forecast
  final Forecast forecast;

  /// The list of attached forecasts
  final List<Forecast> dayForecast;

  /// The name of the city
  final String city;

  /// The ForecastPage constructor
  const ForecastPage({
    Key? key,
    required this.forecast,
    required this.dayForecast,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          image: WeatherDecoration(
            forecast.weather.isNotEmpty ? forecast.weather.first.id : 0,
            opacity: 1,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              DateFormat.yMMMMEEEEd(
                      Localizations.localeOf(context).languageCode)
                  .format(forecast.dt),
            ),
            bottom: PreferredSize(
                child: Row(
                  children: [
                    _cityName(context),
                    _weatherIcon(forecast.weather.isNotEmpty
                        ? forecast.weather.first.icon
                        : null),
                  ],
                ),
                preferredSize: const Size.fromHeight(100)),
          ),
          body: _body(context),
        ),
      );

  Widget _cityName(BuildContext context) => Expanded(
        child: Padding(
          child: Marquee(
            child: Text(
              city,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          padding: const EdgeInsets.all(16),
        ),
      );

  Widget _weatherIcon(String? icon) =>
      icon != null ? OpenWeatherMapIcon(icon) : Container();

  Widget _body(BuildContext context) => Stack(
        children: [
          Opacity(
            child: Container(
              color: Colors.black,
            ),
            opacity: 0.5,
          ),
          ListView.separated(
            itemBuilder: (context, index) => ForecastItem(
              forecast: dayForecast[index],
            ),
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemCount: dayForecast.length,
          ),
        ],
      );
}
