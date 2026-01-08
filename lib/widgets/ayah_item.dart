import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/ayah_model.dart';

/// Individual Ayah Item Widget
/// Displays a single verse with proper Arabic styling
class AyahItem extends StatelessWidget {
  final AyahModel ayah;
  final bool isDarkMode;
  final bool showTranslation;
  final String? translationText;

  const AyahItem({
    super.key,
    required this.ayah,
    required this.isDarkMode,
    this.showTranslation = false,
    this.translationText,
  });

  /// Helper method to create color with alpha
  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? _withAlpha(Colors.white, 0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withAlpha(30)
                : AppColors.primaryMaroon.withAlpha(10),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Ayah Number Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAyahNumberBadge(),
              // Additional actions can go here (bookmark, share, etc.)
            ],
          ),

          const SizedBox(height: 16),

          // Arabic Text
          Text(
            ayah.text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              fontFamily: 'Amiri',
              height: 2.0,
              color: isDarkMode ? Colors.white : AppColors.textDark,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),

          // Translation (if enabled)
          if (showTranslation && translationText != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? _withAlpha(Colors.white, 0.05)
                    : _withAlpha(AppColors.primaryMaroon, 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                translationText!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                  color: isDarkMode
                      ? _withAlpha(Colors.white, 0.85)
                      : _withAlpha(AppColors.textDark, 0.85),
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAyahNumberBadge() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [
                  _withAlpha(Colors.white, 0.2),
                  _withAlpha(Colors.white, 0.1),
                ]
              : [
                  _withAlpha(AppColors.primaryMaroon, 0.15),
                  _withAlpha(AppColors.primaryMaroon, 0.08),
                ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDarkMode
              ? _withAlpha(Colors.white, 0.2)
              : _withAlpha(AppColors.primaryMaroon, 0.25),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          ayah.numberInSurah.toString(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : AppColors.primaryMaroon,
          ),
        ),
      ),
    );
  }
}

/// Ayah Loading Skeleton
class AyahSkeleton extends StatelessWidget {
  final bool isDarkMode;

  const AyahSkeleton({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final baseColor = isDarkMode
        ? Colors.white.withAlpha(30)
        : AppColors.primaryMaroon.withAlpha(20);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withAlpha(15) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withAlpha(30)
                : AppColors.primaryMaroon.withAlpha(10),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Badge skeleton
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 16),

          // Text skeleton lines
          Container(
            height: 24,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 24,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 24,
            width: MediaQuery.of(context).size.width * 0.5,
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

/// Animated Skeleton for loading state
class AnimatedAyahSkeleton extends StatefulWidget {
  final bool isDarkMode;

  const AnimatedAyahSkeleton({super.key, required this.isDarkMode});

  @override
  State<AnimatedAyahSkeleton> createState() => _AnimatedAyahSkeletonState();
}

class _AnimatedAyahSkeletonState extends State<AnimatedAyahSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: AyahSkeleton(isDarkMode: widget.isDarkMode),
        );
      },
    );
  }
}
