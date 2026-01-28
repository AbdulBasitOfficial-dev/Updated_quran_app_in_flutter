import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/dua_model.dart';

/// Reusable Dua Card Widget
/// Displays a Dua with title, Arabic text, transliteration, meaning, and reference
class DuaCard extends StatelessWidget {
  final DuaModel dua;
  final bool isDarkMode;

  const DuaCard({super.key, required this.dua, required this.isDarkMode});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row with Number
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNumberBadge(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dua.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? Colors.white : AppColors.textDark,
                          letterSpacing: 0.2,
                        ),
                      ),
                      if (dua.reference != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          dua.reference!,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? _withAlpha(Colors.white, 0.6)
                                : _withAlpha(AppColors.primaryMaroon, 0.8),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Arabic Text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? _withAlpha(AppColors.primaryMaroon, 0.12)
                    : _withAlpha(AppColors.primaryMaroon, 0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                dua.arabicText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Amiri',
                  color: isDarkMode ? Colors.white : AppColors.textDark,
                  height: 1.7,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),

            const SizedBox(height: 12),

            // Transliteration
            Text(
              dua.transliteration,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: isDarkMode
                    ? _withAlpha(Colors.white, 0.85)
                    : AppColors.primaryMaroon,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 8),

            // English Meaning
            Text(
              dua.englishMeaning,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: isDarkMode
                    ? _withAlpha(Colors.white, 0.7)
                    : _withAlpha(AppColors.textDark, 0.7),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberBadge() {
    return Container(
      width: 36,
      height: 36,
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
          dua.number.toString(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Loading Skeleton for Dua Card
class DuaCardSkeleton extends StatelessWidget {
  final bool isDarkMode;

  const DuaCardSkeleton({super.key, required this.isDarkMode});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title skeleton
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: 140,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 12,
                    width: 60,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Arabic text skeleton
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 12),
          // Transliteration skeleton
          Container(
            height: 14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          // Meaning skeleton
          Container(
            height: 12,
            width: 180,
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
