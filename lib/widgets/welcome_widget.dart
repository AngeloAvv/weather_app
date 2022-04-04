import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather/cubits/search_cubit.dart';
import 'package:weather/misc/decorators/weather_decoration.dart';

/// A widget used on the main page to welcome the user in the app
class WelcomeWidget extends StatelessWidget {
  /// The callback function to back-propagate the onTap event on the search button
  final VoidCallback? onTap;

  /// The WelcomeWidget constructor
  const WelcomeWidget({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: BlocBuilder<SearchCubit, bool>(
            builder: (context, isSearching) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _title(context),
                Container(height: 16),
                _subtitle(context),
                if (!isSearching) _button(context),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          image: WeatherDecoration.clearDay(),
        ),
      );

  Widget _title(BuildContext context) => Text(
        AppLocalizations.of(context)?.label_welcome ?? '',
        key: const Key('txt_welcome'),
        style: Theme.of(context).textTheme.headline2,
      );

  Widget _subtitle(BuildContext context) => Text(
        AppLocalizations.of(context)?.label_search ?? '',
        key: const Key('txt_search'),
        style: Theme.of(context).textTheme.subtitle1,
      );

  Widget _button(BuildContext context) => Padding(
        child: OutlinedButton.icon(
          key: const Key('btn_action_search'),
          icon: const Icon(Icons.search),
          label: Text(AppLocalizations.of(context)?.action_search ?? ''),
          onPressed: onTap,
        ),
        padding: const EdgeInsets.only(top: 16),
      );
}
