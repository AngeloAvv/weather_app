import 'package:flutter/material.dart';
import 'package:weather/features/localizations/extensions/localizations_extensions.dart';
import 'package:weather/misc/decorators/weather_decoration.dart';

/// A widget used on the main page to welcome the user in the app
class WelcomeWidget extends StatelessWidget {
  /// The callback function to back-propagate the onTap event on the search button
  final GestureTapCallback? onTap;

  /// A flag to indicate if the widget is in a searching state
  final bool searching;

  /// The WelcomeWidget constructor
  const WelcomeWidget({
    super.key,
    this.onTap,
    this.searching = false,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: WeatherDecoration.clearDay(),
        ),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n?.label_welcome ?? 'label_welcome',
                  key: const Key('txt_welcome'),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Container(height: 16),
                Text(
                  context.l10n?.label_search ?? 'label_search',
                  key: const Key('txt_search'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (!searching) Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: OutlinedButton.icon(
                    key: const Key('btn_action_search'),
                    icon: const Icon(Icons.search),
                    label: Text(context.l10n?.action_search ?? 'action_search'),
                    onPressed: onTap,
                  ),
                ),
              ],
          ),
        ),
      );
}
