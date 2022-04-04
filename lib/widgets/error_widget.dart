import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather/cubits/search_cubit.dart';
import 'package:weather/misc/decorators/weather_decoration.dart';

/// A support widget to show the proper error while getting the forecast
class ErrorWidget extends StatelessWidget {
  /// The optional searched city
  final String? city;

  /// A boolean indicating wether to show the not found message
  final bool notFound;

  /// A boolean indicating wether to show the invalid API token message
  final bool invalidAPIToken;

  /// A boolean indicating wether to show the no internet message
  final bool noInternet;

  /// A boolean indicating wether to show the empty city message
  final bool emptyCity;

  /// The callback function to back-propagate the onTap event
  final VoidCallback? onTap;

  /// The ErrorWidget constructor
  const ErrorWidget({
    Key? key,
    this.city,
    this.notFound = false,
    this.invalidAPIToken = false,
    this.noInternet = false,
    this.emptyCity = false,
    this.onTap,
  }) : super(key: key);

  /// The not found factory constructor
  factory ErrorWidget.notFound(
    String city, {
    Key? key,
    VoidCallback? onTap,
  }) =>
      ErrorWidget(
        city: city,
        key: key,
        notFound: true,
        onTap: onTap,
      );

  /// The invalid API Token factory constructor
  factory ErrorWidget.invalidAPIToken({
    Key? key,
    VoidCallback? onTap,
  }) =>
      ErrorWidget(
        key: key,
        invalidAPIToken: true,
        onTap: onTap,
      );

  /// The no internet factory constructor
  factory ErrorWidget.noInternet({
    Key? key,
    VoidCallback? onTap,
  }) =>
      ErrorWidget(
        key: key,
        noInternet: true,
        onTap: onTap,
      );

  /// The empty city factory constructor
  factory ErrorWidget.emptyCity({
    Key? key,
    VoidCallback? onTap,
  }) =>
      ErrorWidget(
        key: key,
        emptyCity: true,
        onTap: onTap,
      );

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
          image: WeatherDecoration.rain(),
        ),
      );

  Widget _title(BuildContext context) => Text(
        AppLocalizations.of(context)?.error_uh_oh ?? '',
        key: const Key('txt_error_title'),
        style: Theme.of(context).textTheme.headline2,
      );

  Widget _subtitle(BuildContext context) {
    String text = AppLocalizations.of(context)?.error_generic ?? '';

    if (notFound) {
      text = AppLocalizations.of(context)?.error_not_found(city!) ?? '';
    } else if (invalidAPIToken) {
      text = AppLocalizations.of(context)?.error_unauthorized ?? '';
    } else if (noInternet) {
      text = AppLocalizations.of(context)?.error_no_internet ?? '';
    } else if (emptyCity) {
      text = AppLocalizations.of(context)?.error_empty_city ?? '';
    }

    return Text(
      text,
      key: const Key('txt_error_subtitle'),
      style: Theme.of(context).textTheme.subtitle1,
      textAlign: TextAlign.center,
    );
  }

  Widget _button(BuildContext context) => Padding(
        child: OutlinedButton.icon(
          //highlightedBorderColor: Colors.white,
          icon: Icon(noInternet ? Icons.settings : Icons.search),
          label: Text(noInternet
              ? AppLocalizations.of(context)?.action_fix ?? ''
              : AppLocalizations.of(context)?.action_search ?? ''),
          onPressed: onTap,
        ),
        padding: const EdgeInsets.only(top: 16),
      );
}
