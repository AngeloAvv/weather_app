import 'package:flutter/material.dart';
import 'package:weather/features/localizations/extensions/localizations_extensions.dart';

/// The SearchButton widget
class SearchButton extends StatelessWidget {
  /// The callback function to back-propagate the onTap event on the search button
  final GestureTapCallback? onPressed;

  /// The SearchButton constructor
  const SearchButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
    icon: const Icon(Icons.search),
    tooltip: context.l10n?.tooltip_search ??
        'tooltip_search',
    onPressed: onPressed,
  );
}
