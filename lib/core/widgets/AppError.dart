import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final String? message;

  const AppError({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Takes only necessary space
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: 32,
              color: colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),

            const SizedBox(height: 12),

            Text(
              message ?? "Content unavailable",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.4, // Increases line height for better readability
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}