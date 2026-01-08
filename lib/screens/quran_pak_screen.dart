import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_assets.dart';
import '../constants/app_strings.dart';
import '../models/parah_model.dart';
import '../models/surah_model.dart';
import '../services/api_service.dart';
import '../widgets/shimmer_loading.dart';
import 'surah_detail_screen.dart';
import 'parah_detail_screen.dart';

/// Quran Pak Screen
/// Shows Parah (Juz) and Surah lists with lazy loading
class QuranPakScreen extends StatefulWidget {
  const QuranPakScreen({super.key});

  @override
  State<QuranPakScreen> createState() => _QuranPakScreenState();
}

class _QuranPakScreenState extends State<QuranPakScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ApiService _apiService = ApiService();
  
  // Parah data
  List<ParahModel> _parahs = [];
  List<ParahModel> _filteredParahs = [];
  bool _isLoadingParahs = true;
  
  // Surah data
  List<SurahModel> _surahs = [];
  List<SurahModel> _filteredSurahs = [];
  bool _isLoadingSurahs = true;
  
  // Search controllers
  final TextEditingController _parahSearchController = TextEditingController();
  final TextEditingController _surahSearchController = TextEditingController();
  
  // Scroll controllers for lazy loading
  final ScrollController _parahScrollController = ScrollController();
  final ScrollController _surahScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
    
    // Listen to search changes
    _parahSearchController.addListener(_onParahSearchChanged);
    _surahSearchController.addListener(_onSurahSearchChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _parahSearchController.dispose();
    _surahSearchController.dispose();
    _parahScrollController.dispose();
    _surahScrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _loadParahs(),
      _loadSurahs(),
    ]);
  }

  Future<void> _loadParahs() async {
    try {
      final parahs = await _apiService.getParahs();
      if (mounted) {
        setState(() {
          _parahs = parahs;
          _filteredParahs = parahs;
          _isLoadingParahs = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingParahs = false;
        });
        _showError('Failed to load Parahs');
      }
    }
  }

  Future<void> _loadSurahs() async {
    try {
      final surahs = await _apiService.getSurahs();
      if (mounted) {
        setState(() {
          _surahs = surahs;
          _filteredSurahs = surahs;
          _isLoadingSurahs = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingSurahs = false;
        });
        _showError('Failed to load Surahs');
      }
    }
  }

  void _onParahSearchChanged() {
    final query = _parahSearchController.text;
    setState(() {
      if (query.isEmpty) {
        _filteredParahs = _parahs;
      } else {
        _filteredParahs = _parahs.where((parah) {
          return parah.englishName.toLowerCase().contains(query.toLowerCase()) ||
              parah.arabicName.contains(query) ||
              parah.number.toString().contains(query);
        }).toList();
      }
    });
  }

  void _onSurahSearchChanged() {
    final query = _surahSearchController.text;
    setState(() {
      if (query.isEmpty) {
        _filteredSurahs = _surahs;
      } else {
        _filteredSurahs = _surahs.where((surah) {
          return surah.englishName.toLowerCase().contains(query.toLowerCase()) ||
              surah.name.contains(query) ||
              surah.number.toString().contains(query);
        }).toList();
      }
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
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
      backgroundColor:
          isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Hero Banner Section (same as home)
            _buildHeroBanner(isDarkMode, screenSize),

            const SizedBox(height: 16),

            // Tab Bar
            _buildTabBar(isDarkMode),

            const SizedBox(height: 12),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildParahList(isDarkMode),
                  _buildSurahList(isDarkMode),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the hero banner section
  Widget _buildHeroBanner(bool isDarkMode, Size screenSize) {
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.18,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: _withAlpha(AppColors.primaryMaroon, 0.15),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            AppAssets.topHomePng,
            fit: BoxFit.cover,
          ),

          // Back Button
          Positioned(
            top: 12,
            left: 12,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _withAlpha(Colors.black, 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ),

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
    );
  }

  /// Builds the custom tab bar
  Widget _buildTabBar(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: isDarkMode
              ? _withAlpha(Colors.white, 0.1)
              : _withAlpha(AppColors.primaryMaroon, 0.1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: AppColors.primaryMaroon,
            borderRadius: BorderRadius.circular(25),
          ),
          labelColor: Colors.white,
          unselectedLabelColor:
              isDarkMode ? Colors.white : AppColors.primaryMaroon,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: 'Parah(List)'),
            Tab(text: 'Surah(List)'),
          ],
        ),
      ),
    );
  }

  /// Builds the Parah list tab
  Widget _buildParahList(bool isDarkMode) {
    return Column(
      children: [
        // Search Bar
        _buildSearchBar(
          controller: _parahSearchController,
          hint: 'Search Parah',
          isDarkMode: isDarkMode,
        ),

        const SizedBox(height: 8),

        // List
        Expanded(
          child: _isLoadingParahs
              ? SkeletonList(isDarkMode: isDarkMode)
              : _filteredParahs.isEmpty
                  ? _buildEmptyState('No Parahs found', isDarkMode)
                  : ListView.builder(
                      controller: _parahScrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filteredParahs.length,
                      itemBuilder: (context, index) {
                        final parah = _filteredParahs[index];
                        return _buildParahItem(parah, isDarkMode);
                      },
                    ),
        ),
      ],
    );
  }

  /// Builds the Surah list tab
  Widget _buildSurahList(bool isDarkMode) {
    return Column(
      children: [
        // Search Bar
        _buildSearchBar(
          controller: _surahSearchController,
          hint: 'Search Surah',
          isDarkMode: isDarkMode,
        ),

        const SizedBox(height: 8),

        // List
        Expanded(
          child: _isLoadingSurahs
              ? SkeletonList(isDarkMode: isDarkMode)
              : _filteredSurahs.isEmpty
                  ? _buildEmptyState('No Surahs found', isDarkMode)
                  : ListView.builder(
                      controller: _surahScrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filteredSurahs.length,
                      itemBuilder: (context, index) {
                        final surah = _filteredSurahs[index];
                        return _buildSurahItem(surah, isDarkMode);
                      },
                    ),
        ),
      ],
    );
  }

  /// Builds a search bar
  Widget _buildSearchBar({
    required TextEditingController controller,
    required String hint,
    required bool isDarkMode,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isDarkMode
              ? _withAlpha(Colors.white, 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode
                ? _withAlpha(Colors.white, 0.2)
                : _withAlpha(AppColors.primaryMaroon, 0.15),
            width: 1,
          ),
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
        child: TextField(
          controller: controller,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.white : AppColors.textDark,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14,
              color: isDarkMode
                  ? _withAlpha(Colors.white, 0.5)
                  : _withAlpha(AppColors.textDark, 0.5),
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: isDarkMode
                  ? _withAlpha(Colors.white, 0.6)
                  : _withAlpha(AppColors.textDark, 0.5),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a Parah list item
  Widget _buildParahItem(ParahModel parah, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ParahDetailScreen(parah: parah),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDarkMode
              ? _withAlpha(Colors.white, 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withAlpha(40)
                  : AppColors.primaryMaroon.withAlpha(12),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Number Badge
            _buildNumberBadge(parah.number, isDarkMode),

            const SizedBox(width: 16),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parah.englishName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Surah Al-Baqarah', // Placeholder subtitle
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode
                          ? _withAlpha(Colors.white, 0.6)
                          : _withAlpha(AppColors.textDark, 0.6),
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),

            // Arabic Name
            Text(
              parah.arabicName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Amiri',
                color: isDarkMode
                    ? _withAlpha(Colors.white, 0.9)
                    : AppColors.textDark,
                letterSpacing: 0.5,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a Surah list item
  Widget _buildSurahItem(SurahModel surah, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SurahDetailScreen(surah: surah),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDarkMode
              ? _withAlpha(Colors.white, 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withAlpha(40)
                  : AppColors.primaryMaroon.withAlpha(12),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Number Badge
            _buildNumberBadge(surah.number, isDarkMode),

            const SizedBox(width: 16),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.englishName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Para ${_getParaNumber(surah.number)}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode
                          ? _withAlpha(Colors.white, 0.6)
                          : _withAlpha(AppColors.textDark, 0.6),
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),

            // Arabic Name
            Text(
              surah.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Amiri',
                color: isDarkMode
                    ? _withAlpha(Colors.white, 0.9)
                    : AppColors.textDark,
                letterSpacing: 0.5,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a decorative number badge
  Widget _buildNumberBadge(int number, bool isDarkMode) {
    return Container(
      width: 44,
      height: 44,
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
                  _withAlpha(AppColors.primaryMaroon, 0.12),
                  _withAlpha(AppColors.primaryMaroon, 0.06),
                ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode
              ? _withAlpha(Colors.white, 0.15)
              : _withAlpha(AppColors.primaryMaroon, 0.2),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : AppColors.primaryMaroon,
          ),
        ),
      ),
    );
  }

  /// Builds empty state widget
  Widget _buildEmptyState(String message, bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: isDarkMode
                ? _withAlpha(Colors.white, 0.4)
                : _withAlpha(AppColors.primaryMaroon, 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDarkMode
                  ? _withAlpha(Colors.white, 0.6)
                  : _withAlpha(AppColors.textDark, 0.6),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to get para number for surah
  String _getParaNumber(int surahNumber) {
    // Mapping of surah to para (simplified)
    if (surahNumber == 1) return '1';
    if (surahNumber == 2) return '1-3';
    if (surahNumber == 3) return '3-4';
    if (surahNumber == 4) return '4-6';
    if (surahNumber == 5) return '6-7';
    if (surahNumber == 6) return '7-8';
    if (surahNumber == 7) return '8-9';
    if (surahNumber <= 9) return '${surahNumber - 1}-${surahNumber}';
    return '${(surahNumber / 4).floor() + 1}';
  }
}
