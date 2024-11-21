import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:weather/misc/decorators/weather_decoration.dart';
import 'package:weather/models/forecast/forecast.dart';
import 'package:weather/pages/forecast/widgets/forecast_tile.dart';
import 'package:weather/widgets/owm_icon.dart';

/// The forecast page to show a single forecast
@RoutePage()
class ForecastPage extends StatelessWidget {
  /// The single forecast
  final Forecast forecast;

  /// The list of attached forecasts
  final List<Forecast> dayForecast;

  /// The name of the city
  final String city;

  /// The ForecastPage constructor
  const ForecastPage({
    super.key,
    required this.forecast,
    required this.dayForecast,
    required this.city,
  });

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
                preferredSize: const Size.fromHeight(100),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Marquee(
                          child: Text(
                            city,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                    ),
                    if (forecast.weather.isNotEmpty)
                      OpenWeatherMapIcon(forecast.weather.first.icon),
                  ],
                )),
          ),
          body: Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: Container(
                  color: Colors.black,
                ),
              ),
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final forecast = dayForecast[index];

                  return ForecastTile(forecast);
                },
                separatorBuilder: (_, __) => const Divider(height: 0),
                itemCount: dayForecast.length,
              ),
            ],
          ),
        ),
      );
}
