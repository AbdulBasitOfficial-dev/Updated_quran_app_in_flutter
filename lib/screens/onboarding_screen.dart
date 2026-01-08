import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import 'home_screen.dart';

/// Onboarding Screen Widget
/// Shows two pages with illustrations and descriptions
/// Supports both Light and Dark modes
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Helper method to create color with alpha
  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top spacing
            SizedBox(height: screenSize.height * 0.04),

            // Title with birds
            _buildTopSection(isDarkMode),

            // PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildPage(
                    isDarkMode: isDarkMode,
                    imagePath: 'assets/svg/person1.png',
                    title: AppStrings.onboarding1Title,
                    description: AppStrings.onboarding1Description,
                    buttonText: AppStrings.onboarding1Button,
                    onButtonPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    screenSize: screenSize,
                  ),
                  _buildPage(
                    isDarkMode: isDarkMode,
                    imagePath: 'assets/svg/person2.png',
                    title: AppStrings.onboarding2Title,
                    description: AppStrings.onboarding2Description,
                    buttonText: AppStrings.onboarding2Button,
                    onButtonPressed: () {
                      // Navigate to home screen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    screenSize: screenSize,
                  ),
                ],
              ),
            ),

            // Page Indicator
            _buildPageIndicator(isDarkMode),

            SizedBox(height: screenSize.height * 0.03),
          ],
        ),
      ),
    );
  }

  /// Builds the top section with title and birds
  Widget _buildTopSection(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Flying birds scattered in background
          Positioned(
            left: 20,
            top: -5,
            child: _buildBird(isDarkMode, 8),
          ),
          Positioned(
            right: 30,
            top: -3,
            child: _buildBird(isDarkMode, 7),
          ),
          Positioned(
            left: 80,
            top: 8,
            child: _buildBird(isDarkMode, 6),
          ),
          Positioned(
            right: 70,
            top: 10,
            child: _buildBird(isDarkMode, 7),
          ),
          
          // Title
          Center(
            child: Text(
              AppStrings.onboardingTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : AppColors.textDark,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single bird icon
  Widget _buildBird(bool isDarkMode, double size) {
    return Icon(
      Icons.flutter_dash,
      size: size,
      color: isDarkMode
          ? _withAlpha(Colors.white, 0.4)
          : _withAlpha(AppColors.birdColorLight, 0.35),
    );
  }

  /// Builds a single onboarding page
  Widget _buildPage({
    required bool isDarkMode,
    required String imagePath,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onButtonPressed,
    required Size screenSize,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          SizedBox(height: screenSize.height * 0.06),

          // Illustration with circular frame
          _buildIllustration(isDarkMode, imagePath, screenSize),

          SizedBox(height: screenSize.height * 0.045),

          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : AppColors.textDark,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: screenSize.height * 0.02),

          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: isDarkMode
                  ? _withAlpha(Colors.white, 0.8)
                  : _withAlpha(AppColors.textDark, 0.7),
              letterSpacing: 0.1,
            ),
            textAlign: TextAlign.center,
          ),

          const Spacer(),

          // Action Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode
                    ? AppColors.quranCircleInner
                    : AppColors.primaryMaroon,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),

          SizedBox(height: screenSize.height * 0.02),
        ],
      ),
    );
  }

  /// Builds the circular illustration section
  Widget _buildIllustration(bool isDarkMode, String imagePath, Size screenSize) {
    return Container(
      width: screenSize.width * 0.55,
      height: screenSize.width * 0.55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDarkMode
            ? _withAlpha(Colors.white, 0.15)
            : _withAlpha(AppColors.primaryMaroon, 0.08),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? _withAlpha(Colors.black, 0.2)
                : _withAlpha(AppColors.primaryMaroon, 0.12),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// Builds the page indicator dots
  Widget _buildPageIndicator(bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        2,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? (isDarkMode ? Colors.white : AppColors.primaryMaroon)
                : (isDarkMode
                    ? _withAlpha(Colors.white, 0.3)
                    : _withAlpha(AppColors.primaryMaroon, 0.3)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
