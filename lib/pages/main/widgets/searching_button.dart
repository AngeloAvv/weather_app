import 'package:flutter/material.dart';

/// The SearchingButton widget
class SearchingButton extends StatelessWidget {

  /// The SearchingButton constructor
  const SearchingButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: null,
    icon: SizedBox.fromSize(
      size: const Size(24, 24),
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            Colors.white),
      ),
    ),
  );
}
