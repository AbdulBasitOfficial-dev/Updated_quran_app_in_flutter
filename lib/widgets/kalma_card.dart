import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/kalma_model.dart';

/// Reusable Kalma Card Widget
/// Displays a Kalma with Arabic text, transliteration, and meaning
class KalmaCard extends StatelessWidget {
  final KalmaModel kalma;
  final bool isDarkMode;

  const KalmaCard({super.key, required this.kalma, required this.isDarkMode});

  /// Helper method to create color with alpha
  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? _withAlpha(Colors.white, 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withAlpha(30)
                : AppColors.primaryMaroon.withAlpha(15),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row with Number
            Row(
              children: [
                _buildNumberBadge(),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    kalma.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Arabic Text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? _withAlpha(AppColors.primaryMaroon, 0.15)
                    : _withAlpha(AppColors.primaryMaroon, 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                kalma.arabicText,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Amiri',
                  color: isDarkMode ? Colors.white : AppColors.textDark,
                  height: 1.8,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),

            const SizedBox(height: 14),

            // Transliteration
            Text(
              kalma.transliteration,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: isDarkMode
                    ? _withAlpha(Colors.white, 0.9)
                    : AppColors.primaryMaroon,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 10),

            // English Meaning
            Text(
              kalma.englishMeaning,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: isDarkMode
                    ? _withAlpha(Colors.white, 0.75)
                    : _withAlpha(AppColors.textDark, 0.75),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberBadge() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [_withAlpha(Colors.white, 0.2), _withAlpha(Colors.white, 0.1)]
              : [
                  AppColors.primaryMaroon,
                  _withAlpha(AppColors.primaryMaroon, 0.8),
                ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: isDarkMode
            ? []
            : [
                BoxShadow(
                  color: _withAlpha(AppColors.primaryMaroon, 0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Center(
        child: Text(
          kalma.number.toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Loading Skeleton for Kalma Card
class KalmaCardSkeleton extends StatelessWidget {
  final bool isDarkMode;

  const KalmaCardSkeleton({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final baseColor = isDarkMode
        ? Colors.white.withAlpha(20)
        : AppColors.primaryMaroon.withAlpha(15);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title skeleton
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 20,
                width: 150,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Arabic text skeleton
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 14),
          // Transliteration skeleton
          Container(
            height: 16,
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 10),
          // Meaning skeleton
          Container(
            height: 14,
            width: 200,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
