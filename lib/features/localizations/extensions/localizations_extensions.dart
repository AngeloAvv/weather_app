import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The extension to get the localizations from the context
extension LocalizationsExtensions on BuildContext {
  /// The localizations getter
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
