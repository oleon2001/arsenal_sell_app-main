import 'package:flutter/material.dart';
import '../theme/palette.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppPalette.primary),
            ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppPalette.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      );
}
