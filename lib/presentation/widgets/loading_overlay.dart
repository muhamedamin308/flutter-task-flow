import 'package:flutter/material.dart';

/// Wraps any widget with a semi-transparent loading overlay.
/// Usage: `LoadingOverlay(isLoading: _isLoading, child: MyForm())`
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // AbsorbPointer blocks all touch events when loading, preventing
        // double-submissions if the user taps the button again.
        AbsorbPointer(absorbing: isLoading, child: child),
        if (isLoading)
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.black26,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
