import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_assets.dart';
import '../main.dart';
import '../widgets/app_drawer.dart';
import 'quran_pak_screen.dart';
import 'asma_ul_husna_screen.dart';
import 'muhammad_names_screen.dart';
import 'six_kalma_screen.dart';
import 'masnoon_dua_screen.dart';

/// Home Screen Widget
/// The main screen after onboarding with categories for Islamic content
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  /// Builds the Islamic date section with dynamic current date
  Widget _buildIslamicDate(bool isDarkMode) {
    final now = DateTime.now();
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final dayName = days[now.weekday - 1];
    final monthName = months[now.month - 1];
    final formattedDate = '$dayName, ${now.day} $monthName ${now.year}';

    return Center(
      child: Text(
        formattedDate,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Colors.white : AppColors.textDark,
          letterSpacing: 0.2,
        ),
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
                        fontSize: 22,
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

                    const SizedBox(height: 16),

                    // Current Date
                    Builder(
                      builder: (context) {
                        final now = DateTime.now();
                        final months = [
                          'January',
                          'February',
                          'March',
                          'April',
                          'May',
                          'June',
                          'July',
                          'August',
                          'September',
                          'October',
                          'November',
                          'December',
                        ];
                        final days = [
                          'Monday',
                          'Tuesday',
                          'Wednesday',
                          'Thursday',
                          'Friday',
                          'Saturday',
                          'Sunday',
                        ];
                        final dayName = days[now.weekday - 1];
                        final monthName = months[now.month - 1];
                        final formattedDate =
                            '$dayName, ${now.day} $monthName ${now.year}';

                        return Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _withAlpha(Colors.white, 0.9),
                            letterSpacing: 0.2,
                            shadows: [
                              Shadow(
                                color: _withAlpha(Colors.black, 0.25),
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        );
                      },
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SixKalmaScreen(),
                          ),
                        );
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MasnoonDuaScreen(),
                          ),
                        );
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AsmaUlHusnaScreen(),
                      ),
                    );
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MuhammadNamesScreen(),
                      ),
                    );
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
      behavior: HitTestBehavior.opaque,
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
      behavior: HitTestBehavior.opaque,
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
      behavior: HitTestBehavior.opaque,
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
