import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_assets.dart';
import '../main.dart';
import '../widgets/app_drawer.dart';
import 'quran_pak_screen.dart';

/// Home Screen Widget
/// The main screen after onboarding with categories for Islamic content
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Helper method to create color with alpha
  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final themeProvider = ThemeProviderInheritedWidget.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDarkMode
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      drawer: AppDrawer(themeProvider: themeProvider),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar Section
              _buildAppBar(isDarkMode),

              // Islamic Date Section
              _buildIslamicDate(isDarkMode),

              const SizedBox(height: 20),

              // Hero Banner Section
              _buildHeroBanner(isDarkMode, screenSize),

              // Carousel Indicators
              _buildCarouselIndicators(isDarkMode),

              const SizedBox(height: 24),

              // Categories Section
              _buildCategoriesSection(isDarkMode, screenSize),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the app bar with menu icon and title
  Widget _buildAppBar(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Menu Icon
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.menu,
                size: 24,
                color: isDarkMode ? Colors.white : AppColors.textDark,
              ),
            ),
          ),

          // Title
          Expanded(
            child: Center(
              child: Text(
                AppStrings.homeTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : AppColors.textDark,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),

          // Placeholder for symmetry
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  /// Builds the Islamic date section
  Widget _buildIslamicDate(bool isDarkMode) {
    return Center(
      child: Column(
        children: [
          Text(
            AppStrings.hijriDate,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : AppColors.textDark,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            AppStrings.gregorianDate,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: isDarkMode
                  ? _withAlpha(Colors.white, 0.7)
                  : _withAlpha(AppColors.textDark, 0.6),
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the hero banner section
  Widget _buildHeroBanner(bool isDarkMode, Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: screenSize.height * 0.22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _withAlpha(AppColors.primaryMaroon, 0.15),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.asset(AppAssets.topHomePng, fit: BoxFit.cover),

              // Overlay Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Greeting Text
                    Text(
                      AppStrings.greeting,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                        shadows: [
                          Shadow(
                            color: _withAlpha(Colors.black, 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Next Prayer Time
                    Text(
                      AppStrings.nextPrayerLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: _withAlpha(Colors.white, 0.85),
                        letterSpacing: 0.1,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Prayer Time
                    Text(
                      AppStrings.nextPrayerTime,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                        shadows: [
                          Shadow(
                            color: _withAlpha(Colors.black, 0.25),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: _withAlpha(Colors.white, 0.85),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          AppStrings.location,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: _withAlpha(Colors.white, 0.85),
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds carousel indicators
  Widget _buildCarouselIndicators(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: _currentCarouselIndex == index ? 20 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: _currentCarouselIndex == index
                  ? (isDarkMode ? Colors.white : AppColors.primaryMaroon)
                  : (isDarkMode
                        ? _withAlpha(Colors.white, 0.35)
                        : _withAlpha(AppColors.primaryMaroon, 0.35)),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the categories section
  Widget _buildCategoriesSection(bool isDarkMode, Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            AppStrings.categoriesTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : AppColors.textDark,
              letterSpacing: 0.2,
            ),
          ),

          const SizedBox(height: 16),

          // Main Category Cards Row (Quran Pak + Six Kalmah/Masnoon Doin)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quran Pak - Large Card
              Expanded(
                child: _buildLargeCategoryCard(
                  isDarkMode: isDarkMode,
                  title: AppStrings.quranPakTitle,
                  iconPath: AppAssets.quranReadPng,
                  isLarge: true,
                  onTap: () {
                    // Navigate to Quran Pak Screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const QuranPakScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              // Right Column - Six Kalmah & Masnoon Doin
              Expanded(
                child: Column(
                  children: [
                    // Six Kalmah Card
                    _buildMediumCategoryCard(
                      isDarkMode: isDarkMode,
                      title: AppStrings.sixKalmahTitle,
                      iconPath: AppAssets.tasbiSvg,
                      isSvg: true,
                      onTap: () {
                        // TODO: Navigate to Six Kalmah
                      },
                    ),

                    const SizedBox(height: 12),

                    // Masnoon Doin Card
                    _buildMediumCategoryCard(
                      isDarkMode: isDarkMode,
                      title: AppStrings.masnoonDoinTitle,
                      iconPath: AppAssets.duaSvg,
                      isSvg: true,
                      onTap: () {
                        // TODO: Navigate to Masnoon Doin
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Bottom Row - Allah Name, Muhammad Name, Azan Screen
          Row(
            children: [
              // Allah Name
              Expanded(
                child: _buildSmallCategoryCard(
                  isDarkMode: isDarkMode,
                  title: AppStrings.allahNameTitle,
                  iconPath: AppAssets.allahNameSvg,
                  onTap: () {
                    // TODO: Navigate to Allah Names
                  },
                ),
              ),

              const SizedBox(width: 12),

              // Muhammad Name
              Expanded(
                child: _buildSmallCategoryCard(
                  isDarkMode: isDarkMode,
                  title: AppStrings.muhammadNameTitle,
                  iconPath: AppAssets.muhammadNameSvg,
                  onTap: () {
                    // TODO: Navigate to Muhammad Names
                  },
                ),
              ),

              const SizedBox(width: 12),

              // Azan Screen
              Expanded(
                child: _buildSmallCategoryCard(
                  isDarkMode: isDarkMode,
                  title: AppStrings.azanScreenTitle,
                  iconPath: AppAssets.azanSvg,
                  onTap: () {
                    // TODO: Navigate to Azan Screen
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a large category card (Quran Pak)
  Widget _buildLargeCategoryCard({
    required bool isDarkMode,
    required String title,
    required String iconPath,
    required bool isLarge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 192,
        decoration: BoxDecoration(
          color: isDarkMode ? _withAlpha(Colors.white, 0.12) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? _withAlpha(Colors.black, 0.2)
                  : _withAlpha(AppColors.primaryMaroon, 0.08),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Image.asset(iconPath, width: 90, height: 90, fit: BoxFit.contain),

            const SizedBox(height: 16),

            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : AppColors.textDark,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a medium category card (Six Kalmah, Masnoon Doin)
  Widget _buildMediumCategoryCard({
    required bool isDarkMode,
    required String title,
    required String iconPath,
    required bool isSvg,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: isDarkMode ? _withAlpha(Colors.white, 0.12) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? _withAlpha(Colors.black, 0.2)
                  : _withAlpha(AppColors.primaryMaroon, 0.08),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            isSvg
                ? SvgPicture.asset(
                    iconPath,
                    width: 40,
                    height: 40,
                    colorFilter: isDarkMode
                        ? ColorFilter.mode(
                            _withAlpha(Colors.white, 0.9),
                            BlendMode.srcIn,
                          )
                        : ColorFilter.mode(
                            AppColors.primaryMaroon,
                            BlendMode.srcIn,
                          ),
                  )
                : Image.asset(
                    iconPath,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),

            const SizedBox(width: 12),

            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : AppColors.textDark,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a small category card (Allah Name, Muhammad Name, Azan Screen)
  Widget _buildSmallCategoryCard({
    required bool isDarkMode,
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: isDarkMode ? _withAlpha(Colors.white, 0.12) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? _withAlpha(Colors.black, 0.2)
                  : _withAlpha(AppColors.primaryMaroon, 0.08),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            SvgPicture.asset(
              iconPath,
              width: 36,
              height: 36,
              colorFilter: isDarkMode
                  ? ColorFilter.mode(
                      _withAlpha(Colors.white, 0.9),
                      BlendMode.srcIn,
                    )
                  : ColorFilter.mode(AppColors.primaryMaroon, BlendMode.srcIn),
            ),

            const SizedBox(height: 10),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : AppColors.textDark,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
