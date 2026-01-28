import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/kalma_model.dart';
import '../services/kalma_service.dart';
import '../widgets/kalma_card.dart';

/// Six Kalma Screen
/// Displays all Six Kalmas with lazy loading
class SixKalmaScreen extends StatefulWidget {
  const SixKalmaScreen({super.key});

  @override
  State<SixKalmaScreen> createState() => _SixKalmaScreenState();
}

class _SixKalmaScreenState extends State<SixKalmaScreen> {
  final KalmaService _kalmaService = KalmaService();
  final ScrollController _scrollController = ScrollController();

  // Data states
  List<KalmaModel> _kalmas = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadKalmas();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadKalmas() async {
    try {
      final kalmas = await _kalmaService.getAllKalmas();
      if (mounted) {
        setState(() {
          _kalmas = kalmas;
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
                  : _buildKalmasList(isDarkMode),
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
                  'Six Kalmas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  'The Six Pillars of Faith',
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
            'سِتّ کَلِمَات',
            style: TextStyle(
              fontSize: 18,
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

  Widget _buildKalmasList(bool isDarkMode) {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: _kalmas.length,
      itemBuilder: (context, index) {
        return KalmaCard(kalma: _kalmas[index], isDarkMode: isDarkMode);
      },
    );
  }

  Widget _buildLoadingState(bool isDarkMode) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemBuilder: (context, index) {
        return KalmaCardSkeleton(isDarkMode: isDarkMode);
      },
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
              'Failed to load Kalmas',
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
                _loadKalmas();
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
