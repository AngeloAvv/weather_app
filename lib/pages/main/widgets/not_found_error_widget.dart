import 'package:flutter/material.dart';
import 'package:weather/features/localizations/extensions/localizations_extensions.dart';
import 'package:weather/misc/decorators/weather_decoration.dart';

/// A widget used on the main page to show the not found error
class NotFoundErrorWidget extends StatelessWidget {
  /// The searched city
  final String city;

  /// The callback function to back-propagate the onTap event
  final GestureTapCallback? onTap;

  /// A boolean indicating wether to show the searching message
  final bool searching;

  /// The NotFoundErrorWidget constructor
  const NotFoundErrorWidget(this.city, {
    super.key,
    this.onTap,
    this.searching = false,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: WeatherDecoration.rain(),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.l10n?.error_uh_oh ?? 'error_uh_oh',
                key: const Key('txt_error_title'),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Container(height: 16),
            Text(
              context.l10n?.error_not_found(city) ?? 'error_not_found_$city',
              key: const Key('txt_error_subtitle'),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
              if (!searching)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: OutlinedButton.icon(
                    //highlightedBorderColor: Colors.white,
                    icon: Icon(Icons.search),
                    label: Text(
                      context.l10n?.action_search ?? 'action_search',
                    ),
                    onPressed: onTap,
                  ),
                ),
            ],
          ),
        ),
      );
}
