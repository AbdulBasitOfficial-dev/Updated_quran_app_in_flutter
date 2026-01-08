import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import 'onboarding_screen.dart';

/// Splash Screen Widget
/// Displays the app branding with bismillah text, flying birds,
/// Quran icon, app title, and mosque silhouette
/// Supports both Light and Dark modes based on system settings
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack),
      ),
    );

    _animationController.forward();
    
    // Navigate to onboarding screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnboardingScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
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
      body: Stack(
        children: [
          // Mosque Silhouette at bottom - positioned absolutely
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: child,
                );
              },
              child: _buildMosqueSilhouette(isDarkMode, screenSize),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Top spacing
                SizedBox(height: screenSize.height * 0.06),

                // Bismillah Text at top
                _buildBismillahSection(isDarkMode),

                // Flying Birds Section - takes remaining space between top and center
                Expanded(
                  flex: 2,
                  child: _buildFlyingBirdsSection(isDarkMode),
                ),

                // Quran Icon with Circle - centered
                _buildQuranIconSection(isDarkMode),

                // App Title
                const SizedBox(height: 20),
                _buildAppTitle(isDarkMode),

                // Bottom space for mosque
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the Bismillah Arabic calligraphy section
  /// Uses bismillah_white.svg for dark mode and bismillah_black.svg for light mode
  Widget _buildBismillahSection(bool isDarkMode) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SvgPicture.asset(
          isDarkMode
              ? 'assets/svg/bismillah_white.svg'
              : 'assets/svg/bismillah_black.svg',
          width: 200,
          height: 38,
        ),
      ),
    );
  }

  /// Builds the flying birds section with scattered birds
  Widget _buildFlyingBirdsSection(bool isDarkMode) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value * 0.6,
          child: child,
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Bird 1 - top left
              Positioned(
                left: constraints.maxWidth * 0.15,
                top: constraints.maxHeight * 0.2,
                child: _buildBird(isDarkMode, 12),
              ),
              // Bird 2 - top center-left
              Positioned(
                left: constraints.maxWidth * 0.25,
                top: constraints.maxHeight * 0.35,
                child: _buildBird(isDarkMode, 10),
              ),
              // Bird 3 - center
              Positioned(
                left: constraints.maxWidth * 0.4,
                top: constraints.maxHeight * 0.25,
                child: _buildBird(isDarkMode, 14),
              ),
              // Bird 4 - top right area
              Positioned(
                right: constraints.maxWidth * 0.25,
                top: constraints.maxHeight * 0.15,
                child: _buildBird(isDarkMode, 11),
              ),
              // Bird 5 - right side
              Positioned(
                right: constraints.maxWidth * 0.15,
                top: constraints.maxHeight * 0.4,
                child: _buildBird(isDarkMode, 13),
              ),
              // Bird 6 - lower left
              Positioned(
                left: constraints.maxWidth * 0.3,
                top: constraints.maxHeight * 0.55,
                child: _buildBird(isDarkMode, 9),
              ),
              // Bird 7 - lower right
              Positioned(
                right: constraints.maxWidth * 0.3,
                top: constraints.maxHeight * 0.5,
                child: _buildBird(isDarkMode, 11),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Builds a single bird icon
  Widget _buildBird(bool isDarkMode, double size) {
    return Icon(
      Icons.flutter_dash,
      size: size,
      color: isDarkMode
          ? _withAlpha(Colors.white, 0.5)
          : _withAlpha(AppColors.birdColorLight, 0.4),
    );
  }

  /// Builds the Quran icon with decorative circle
  /// Uses quran_icon.png as specified
  Widget _buildQuranIconSection(bool isDarkMode) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isDarkMode
                ? Colors.white
                : _withAlpha(AppColors.quranCircleInner, 0.3),
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? _withAlpha(Colors.black, 0.25)
                  : _withAlpha(AppColors.primaryMaroon, 0.15),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode
                  ? [
                      AppColors.quranCircleInner,
                      _withAlpha(AppColors.quranCircleInner, 0.85),
                    ]
                  : [
                      AppColors.circleGradientStart,
                      AppColors.circleGradientEnd,
                    ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                'assets/svg/quran_icon.png',
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the app title text
  Widget _buildAppTitle(bool isDarkMode) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: child,
        );
      },
      child: Text(
        AppStrings.splashTitle,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : AppColors.textDark,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  /// Builds the mosque silhouette at the bottom
  /// Uses mosque.png as specified
  Widget _buildMosqueSilhouette(bool isDarkMode, Size screenSize) {
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height * 0.22,
      child: Image.asset(
        'assets/svg/mosque.png',
        width: screenSize.width,
        fit: BoxFit.cover,
        color: isDarkMode
            ? AppColors.darkMosqueSilhouette
            : AppColors.lightMosqueSilhouette,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}
