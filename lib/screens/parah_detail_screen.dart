import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/parah_model.dart';
import '../models/ayah_model.dart';
import '../services/api_service.dart';
import '../widgets/ayah_item.dart';

/// Parah (Juz) Detail Screen
/// Displays all ayahs of a parah with lazy loading
class ParahDetailScreen extends StatefulWidget {
  final ParahModel parah;

  const ParahDetailScreen({
    super.key,
    required this.parah,
  });

  @override
  State<ParahDetailScreen> createState() => _ParahDetailScreenState();
}

class _ParahDetailScreenState extends State<ParahDetailScreen>
    with SingleTickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  // Data states
  List<AyahModel> _ayahs = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasError = false;
  String _errorMessage = '';

  // Lazy loading
  int _displayedAyahsCount = 0;
  static const int _pageSize = 20;
  bool _hasMoreData = true;

  // Tab state
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollController.addListener(_onScroll);
    _loadParahData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentTab = _tabController.index;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMoreData) {
      _loadMoreAyahs();
    }
  }

  Future<void> _loadParahData() async {
    try {
      final juzDetail = await _apiService.getJuzDetail(widget.parah.number);
      if (mounted) {
        setState(() {
          _ayahs = juzDetail.ayahs;
          _displayedAyahsCount = _ayahs.length.clamp(0, _pageSize);
          _hasMoreData = _displayedAyahsCount < _ayahs.length;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _loadMoreAyahs() {
    if (_isLoadingMore || !_hasMoreData) return;

    setState(() {
      _isLoadingMore = true;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          final newCount = (_displayedAyahsCount + _pageSize).clamp(0, _ayahs.length);
          _displayedAyahsCount = newCount;
          _hasMoreData = _displayedAyahsCount < _ayahs.length;
          _isLoadingMore = false;
        });
      }
    });
  }

  /// Helper method to create color with alpha
  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(isDarkMode),

            // Tabs
            _buildTabs(isDarkMode),

            const SizedBox(height: 8),

            // Content
            Expanded(
              child: _isLoading
                  ? _buildLoadingState(isDarkMode)
                  : _hasError
                      ? _buildErrorState(isDarkMode)
                      : _buildAyahList(isDarkMode),
            ),

            // Parah Name Footer
            _buildFooter(isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryMaroon,
        boxShadow: [
          BoxShadow(
            color: _withAlpha(Colors.black, 0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.arrow_back,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Parah Number Badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _withAlpha(Colors.white, 0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _withAlpha(Colors.white, 0.3),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                widget.parah.number.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Parah Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.parah.englishName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  'Parah ${widget.parah.number}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: _withAlpha(Colors.white, 0.75),
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),

          // Arabic Name
          Text(
            widget.parah.arabicName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Amiri',
              color: _withAlpha(Colors.white, 0.95),
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: isDarkMode
              ? _withAlpha(Colors.white, 0.1)
              : _withAlpha(AppColors.primaryMaroon, 0.08),
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: isDarkMode
                ? _withAlpha(Colors.white, 0.15)
                : _withAlpha(AppColors.primaryMaroon, 0.2),
            width: 1,
          ),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: _currentTab == 0
                ? AppColors.primaryMaroon
                : (isDarkMode ? Colors.white : AppColors.primaryMaroon),
            borderRadius: BorderRadius.circular(21),
          ),
          labelColor: Colors.white,
          unselectedLabelColor:
              isDarkMode ? Colors.white : AppColors.primaryMaroon,
          labelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: 'Read Quran'),
            Tab(text: 'Translation'),
          ],
        ),
      ),
    );
  }

  Widget _buildAyahList(bool isDarkMode) {
    return TabBarView(
      controller: _tabController,
      children: [
        // Read Quran Tab
        _buildQuranReadingView(isDarkMode),
        // Translation Tab (shows same for now - can add translation later)
        _buildQuranReadingView(isDarkMode),
      ],
    );
  }

  Widget _buildQuranReadingView(bool isDarkMode) {
    return Column(
      children: [
        // Decorative Header
        _buildDecorativeHeader(isDarkMode),

        // Ayah List
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: _displayedAyahsCount + (_hasMoreData ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= _displayedAyahsCount) {
                return _buildLoadingIndicator(isDarkMode);
              }
              final ayah = _ayahs[index];
              return AyahItem(
                ayah: ayah,
                isDarkMode: isDarkMode,
                showTranslation: false,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDecorativeHeader(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [
                  _withAlpha(Colors.white, 0.12),
                  _withAlpha(Colors.white, 0.06),
                ]
              : [
                  _withAlpha(AppColors.primaryMaroon, 0.08),
                  _withAlpha(AppColors.primaryMaroon, 0.03),
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode
              ? _withAlpha(Colors.white, 0.15)
              : _withAlpha(AppColors.primaryMaroon, 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Decorative Border Top
          Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  isDarkMode
                      ? _withAlpha(Colors.white, 0.4)
                      : _withAlpha(AppColors.primaryMaroon, 0.4),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Parah Name in Arabic
          Text(
            widget.parah.arabicName,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              fontFamily: 'Amiri',
              color: isDarkMode ? Colors.white : AppColors.textDark,
              letterSpacing: 1,
            ),
            textDirection: TextDirection.rtl,
          ),

          const SizedBox(height: 8),

          // Ayah count info
          Text(
            '${_ayahs.length} Ayahs',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDarkMode
                  ? _withAlpha(Colors.white, 0.7)
                  : _withAlpha(AppColors.textDark, 0.7),
            ),
          ),

          const SizedBox(height: 16),

          // Decorative Border Bottom
          Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  isDarkMode
                      ? _withAlpha(Colors.white, 0.4)
                      : _withAlpha(AppColors.primaryMaroon, 0.4),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(bool isDarkMode) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return AnimatedAyahSkeleton(isDarkMode: isDarkMode);
      },
    );
  }

  Widget _buildLoadingIndicator(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              isDarkMode ? Colors.white : AppColors.primaryMaroon,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(bool isDarkMode) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: isDarkMode
                  ? _withAlpha(Colors.white, 0.5)
                  : _withAlpha(AppColors.primaryMaroon, 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load Parah',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode
                    ? _withAlpha(Colors.white, 0.7)
                    : _withAlpha(AppColors.textDark, 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _hasError = false;
                });
                _loadParahData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryMaroon,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(bool isDarkMode) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? _withAlpha(Colors.white, 0.05)
            : _withAlpha(AppColors.primaryMaroon, 0.05),
        border: Border(
          top: BorderSide(
            color: isDarkMode
                ? _withAlpha(Colors.white, 0.1)
                : _withAlpha(AppColors.primaryMaroon, 0.1),
            width: 1,
          ),
        ),
      ),
      child: Text(
        widget.parah.arabicName,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          fontFamily: 'Amiri',
          color: isDarkMode ? Colors.white : AppColors.textDark,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
