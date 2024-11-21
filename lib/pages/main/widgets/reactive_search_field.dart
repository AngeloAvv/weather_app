import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:weather/features/localizations/extensions/localizations_extensions.dart';

/// The reactive search field
class ReactiveSearchField extends StatelessWidget {
  /// The form control name
  final String formControlName;
  /// The on submitted callback
  final ReactiveFormFieldCallback<String>? onSubmitted;

  /// The ReactiveSearchField constructor
  const ReactiveSearchField({
    super.key,
    required this.formControlName,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) => ReactiveTextField(
        autofocus: true,
        showErrors: (_) => false,
        formControlName: formControlName,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: context.l10n?.hint_search ?? 'hint_search',
        ),
        onSubmitted: onSubmitted,
      );
}
