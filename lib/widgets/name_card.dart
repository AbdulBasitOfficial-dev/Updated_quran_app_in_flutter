import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/name_model.dart';

/// Reusable Name Card Widget
/// Displays an Islamic name with Arabic text, transliteration, and meaning
class NameCard extends StatelessWidget {
  final NameModel name;
  final bool isDarkMode;

  const NameCard({super.key, required this.name, required this.isDarkMode});

  /// Helper method to create color with alpha
  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Number Badge
            _buildNumberBadge(),

            const SizedBox(width: 16),

            // Name Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Arabic Name (RTL)
                  Text(
                    name.arabicName,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Amiri',
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                      height: 1.4,
                    ),
                    textDirection: TextDirection.rtl,
                  ),

                  const SizedBox(height: 6),

                  // Transliteration
                  Text(
                    name.transliteration,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode
                          ? _withAlpha(Colors.white, 0.95)
                          : AppColors.primaryMaroon,
                      letterSpacing: 0.3,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // English Meaning
                  Text(
                    name.englishMeaning,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode
                          ? _withAlpha(Colors.white, 0.7)
                          : _withAlpha(AppColors.textDark, 0.7),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberBadge() {
    return Container(
      width: 44,
      height: 44,
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
        borderRadius: BorderRadius.circular(12),
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
          name.number.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Loading Skeleton for Name Card
class NameCardSkeleton extends StatelessWidget {
  final bool isDarkMode;

  const NameCardSkeleton({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final baseColor = isDarkMode
        ? Colors.white.withAlpha(20)
        : AppColors.primaryMaroon.withAlpha(15);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Number skeleton
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 28,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 16,
                  width: 120,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 14,
                  width: 180,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
