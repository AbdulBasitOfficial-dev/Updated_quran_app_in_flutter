import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';
import 'providers/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NoorAlQuranApp());
}

/// Main Application Widget
/// Supports light and dark mode with persistent theme storage
class NoorAlQuranApp extends StatefulWidget {
  const NoorAlQuranApp({super.key});

  @override
  State<NoorAlQuranApp> createState() => _NoorAlQuranAppState();
}

class _NoorAlQuranAppState extends State<NoorAlQuranApp> {
  late final ThemeProvider _themeProvider;

  @override
  void initState() {
    super.initState();
    _themeProvider = ThemeProvider();
    _themeProvider.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    _themeProvider.removeListener(_onThemeChanged);
    _themeProvider.dispose();
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProviderInheritedWidget(
      themeProvider: _themeProvider,
      child: MaterialApp(
        title: 'Noor Al Quran',
        debugShowCheckedModeBanner: false,

        // Theme Configuration
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeProvider.themeMode,

        // Initial Route - Splash Screen
        home: const SplashScreen(),
      ),
    );
  }
}

/// InheritedWidget to provide ThemeProvider down the widget tree
class ThemeProviderInheritedWidget extends InheritedWidget {
  final ThemeProvider themeProvider;

  const ThemeProviderInheritedWidget({
    super.key,
    required this.themeProvider,
    required super.child,
  });

  static ThemeProvider of(BuildContext context) {
    final widget = context
        .dependOnInheritedWidgetOfExactType<ThemeProviderInheritedWidget>();
    if (widget == null) {
      throw FlutterError(
        'ThemeProviderInheritedWidget not found in widget tree',
      );
    }
    return widget.themeProvider;
  }

  static ThemeProvider? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ThemeProviderInheritedWidget>()
        ?.themeProvider;
  }

  @override
  bool updateShouldNotify(ThemeProviderInheritedWidget oldWidget) {
    return themeProvider.themeMode != oldWidget.themeProvider.themeMode;
  }
}
