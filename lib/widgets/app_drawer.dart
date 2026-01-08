import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../providers/theme_provider.dart';

/// App Drawer Widget
/// Provides navigation and theme toggle functionality
class AppDrawer extends StatelessWidget {
  final ThemeProvider themeProvider;

  const AppDrawer({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeProvider.isDarkMode;

    return Drawer(
      backgroundColor: isDarkMode
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      child: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(isDarkMode),

            const SizedBox(height: 24),

            // Divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(
                color: isDarkMode
                    ? Colors.white.withAlpha(51)
                    : AppColors.textDark.withAlpha(51),
                height: 1,
              ),
            ),

            const SizedBox(height: 24),

            // Theme Toggle Section
            _buildThemeToggle(context, isDarkMode),

            const Spacer(),

            // Footer Section
            _buildFooter(isDarkMode),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Builds the header section with app logo and name
  Widget _buildHeader(bool isDarkMode) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode
              ? [
                  AppColors.darkBackground,
                  AppColors.darkBackground.withAlpha(230),
                ]
              : [
                  AppColors.primaryMaroon.withAlpha(25),
                  AppColors.lightBackground,
                ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Logo
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withAlpha(30) : Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryMaroon.withAlpha(30),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/svg/quran_icon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // App Name
          Text(
            'Noor Al Quran',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : AppColors.textDark,
              letterSpacing: 0.3,
            ),
          ),

          const SizedBox(height: 4),

          // App Tagline
          Text(
            'Illuminate your soul',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isDarkMode
                  ? Colors.white.withAlpha(179)
                  : AppColors.textDark.withAlpha(153),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the theme toggle section
  Widget _buildThemeToggle(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white.withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withAlpha(51)
                  : AppColors.primaryMaroon.withAlpha(20),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withAlpha(30)
                    : AppColors.primaryMaroon.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                color: isDarkMode ? Colors.white : AppColors.primaryMaroon,
                size: 24,
              ),
            ),

            const SizedBox(width: 14),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isDarkMode ? 'Currently enabled' : 'Currently disabled',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode
                          ? Colors.white.withAlpha(153)
                          : AppColors.textDark.withAlpha(128),
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),

            // Toggle Switch
            Switch.adaptive(
              value: isDarkMode,
              onChanged: (value) {
                themeProvider.setDarkMode(value);
              },
              activeColor: Colors.white,
              activeTrackColor: AppColors.primaryMaroon.withAlpha(230),
              inactiveThumbColor: AppColors.primaryMaroon,
              inactiveTrackColor: AppColors.primaryMaroon.withAlpha(77),
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the footer section
  Widget _buildFooter(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Divider(
            color: isDarkMode
                ? Colors.white.withAlpha(51)
                : AppColors.textDark.withAlpha(51),
            height: 1,
          ),
          const SizedBox(height: 16),
          Text(
            'Version 1.0.0',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: isDarkMode
                  ? Colors.white.withAlpha(128)
                  : AppColors.textDark.withAlpha(102),
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
