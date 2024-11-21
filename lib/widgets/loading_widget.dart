import 'package:flutter/material.dart';

/// The loading widget
class LoadingWidget extends StatelessWidget {
  /// The LoadingWidget constructor
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}
