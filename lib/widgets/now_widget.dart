import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:weather/models/forecast.dart';
import 'package:weather/widgets/owm_icon.dart';
import 'package:weather/widgets/sensor_widget.dart';

/// A widget that show the current forecast for a particular city
class NowWidget extends StatelessWidget {
  /// The city name
  final String city;

  /// The forecast associated with the city
  final Forecast? forecast;

  /// Constructor of the NowWidget
  const NowWidget({
    Key? key,
    required this.city,
    this.forecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => OrientationBuilder(
        builder: (context, orientation) => orientation == Orientation.portrait
            ? _portraitOrientation(context)
            : _landscapeOrientation(context),
      );

  Widget _portraitOrientation(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            child: Marquee(
              child: _cityName(context),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          _weatherStatus(),
          if (forecast?.weather.isNotEmpty ?? false)
            _weatherIcon(forecast!.weather.first.icon),
          _temperature(context),
          _temperatures(context),
        ],
      );

  Widget _landscapeOrientation(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                if (forecast?.weather.isNotEmpty ?? false)
                  _weatherIcon(forecast!.weather.first.icon),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Marquee(
                        child: _cityName(context, padding: EdgeInsets.zero),
                      ),
                      _weatherStatus(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _temperature(context),
                _temperatures(context, landscape: true),
              ],
            ),
          ),
        ],
      );

  Widget _cityName(BuildContext context,
          {EdgeInsets padding = const EdgeInsets.all(16)}) =>
      Padding(
        child: Text(
          city,
          style: Theme.of(context).textTheme.headline4,
        ),
        padding: padding,
      );

  Widget _weatherStatus() => forecast?.weather.isNotEmpty ?? false
      ? Text(forecast!.weather.first.description)
      : Container();

  Widget _weatherIcon(String icon) => OpenWeatherMapIcon(icon);

  Widget _temperature(BuildContext context) => forecast?.main.temp != null
      ? Text(
          '${forecast?.main.temp.round()}°C',
          style: Theme.of(context).textTheme.headline2,
        )
      : Container();

  Widget _temperatures(BuildContext context, {bool landscape = false}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (forecast?.main.tempMin != null)
            SensorWidget(
              title: AppLocalizations.of(context)?.label_min,
              value: '${forecast?.main.tempMin.round()}°C',
              landscape: landscape,
            ),
          SizedBox(
            height: landscape ? 20 : 30,
            child: const VerticalDivider(width: 24, color: Colors.white),
          ),
          if (forecast?.main.tempMax != null)
            SensorWidget(
              title: AppLocalizations.of(context)?.label_max,
              value: '${forecast?.main.tempMax.round()}°C',
              landscape: landscape,
            ),
        ],
      );
}
