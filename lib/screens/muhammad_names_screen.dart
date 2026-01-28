import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/name_model.dart';
import '../services/names_api_service.dart';
import '../widgets/name_card.dart';

/// Muhammad Names Screen
/// Displays the Names of Prophet Muhammad ﷺ with lazy loading
class MuhammadNamesScreen extends StatefulWidget {
  const MuhammadNamesScreen({super.key});

  @override
  State<MuhammadNamesScreen> createState() => _MuhammadNamesScreenState();
}

class _MuhammadNamesScreenState extends State<MuhammadNamesScreen> {
  final NamesApiService _apiService = NamesApiService();
  final ScrollController _scrollController = ScrollController();

  // Data states
  List<NameModel> _names = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasError = false;
  String _errorMessage = '';

  // Pagination
  int _currentPage = 0;
  static const int _pageSize = 15;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadNames();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMoreData) {
      _loadMoreNames();
    }
  }

  Future<void> _loadNames() async {
    try {
      final names = await _apiService.getMuhammadNamesPaginated(
        page: 0,
        pageSize: _pageSize,
      );
      if (mounted) {
        setState(() {
          _names = names;
          _currentPage = 0;
          _hasMoreData = names.length >= _pageSize;
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

  Future<void> _loadMoreNames() async {
    if (_isLoadingMore || !_hasMoreData) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final newNames = await _apiService.getMuhammadNamesPaginated(
        page: nextPage,
        pageSize: _pageSize,
      );

      if (mounted) {
        setState(() {
          _names.addAll(newNames);
          _currentPage = nextPage;
          _hasMoreData = newNames.length >= _pageSize;
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
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
      backgroundColor: isDarkMode
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(isDarkMode),

            // Content
            Expanded(
              child: _isLoading
                  ? _buildLoadingState(isDarkMode)
                  : _hasError
                  ? _buildErrorState(isDarkMode)
                  : _buildNamesList(isDarkMode),
            ),
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

          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Names of Muhammad ﷺ',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  'Blessed Names of the Prophet',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _withAlpha(Colors.white, 0.8),
                  ),
                ),
              ],
            ),
          ),

          // Arabic Title
          Text(
            'أَسْمَاءُ النَّبِيِّ ﷺ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Amiri',
              color: _withAlpha(Colors.white, 0.95),
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildNamesList(bool isDarkMode) {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: _names.length + (_hasMoreData ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= _names.length) {
          return _buildLoadingIndicator(isDarkMode);
        }
        return NameCard(name: _names[index], isDarkMode: isDarkMode);
      },
    );
  }

  Widget _buildLoadingState(bool isDarkMode) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemBuilder: (context, index) {
        return NameCardSkeleton(isDarkMode: isDarkMode);
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
              'Failed to load Names',
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
                _loadNames();
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
}
