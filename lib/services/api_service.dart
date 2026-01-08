import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/surah_model.dart';
import '../models/parah_model.dart';
import '../models/ayah_model.dart';

/// API Service for Quran data
/// Uses AlQuran Cloud API (https://api.alquran.cloud/v1)
class ApiService {
  static const String _baseUrl = 'https://api.alquran.cloud/v1';
  
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Cache for API responses
  List<SurahModel>? _cachedSurahs;
  List<ParahModel>? _cachedParahs;
  final Map<int, SurahDetailData> _cachedSurahDetails = {};
  final Map<int, JuzDetailData> _cachedJuzDetails = {};
  final Map<int, List<AyahModel>> _cachedTranslations = {};

  /// Fetch all Surahs from API
  /// Returns cached data if available
  Future<List<SurahModel>> getSurahs() async {
    // Return cached data if available
    if (_cachedSurahs != null) {
      return _cachedSurahs!;
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/surah'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final surahResponse = SurahListResponse.fromJson(jsonData);
        _cachedSurahs = surahResponse.data;
        return _cachedSurahs!;
      } else {
        throw Exception('Failed to load Surahs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Surahs: $e');
    }
  }

  /// Get all Parahs (Juz)
  /// Uses predefined static data since API doesn't provide direct Juz list
  Future<List<ParahModel>> getParahs() async {
    // Return cached data if available
    if (_cachedParahs != null) {
      return _cachedParahs!;
    }

    // Simulate network delay for smooth loading animation
    await Future.delayed(const Duration(milliseconds: 300));
    
    _cachedParahs = ParahModel.getAllParahs();
    return _cachedParahs!;
  }

  /// Fetch Surah detail with all ayahs (Arabic - Uthmani script)
  Future<SurahDetailData> getSurahDetail(int surahNumber) async {
    // Return cached data if available
    if (_cachedSurahDetails.containsKey(surahNumber)) {
      return _cachedSurahDetails[surahNumber]!;
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/surah/$surahNumber/quran-uthmani'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final surahResponse = SurahDetailResponse.fromJson(jsonData);
        if (surahResponse.data != null) {
          _cachedSurahDetails[surahNumber] = surahResponse.data!;
          return surahResponse.data!;
        }
        throw Exception('No data received for Surah $surahNumber');
      } else {
        throw Exception('Failed to load Surah detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Surah detail: $e');
    }
  }

  /// Fetch Surah translation (English)
  Future<List<AyahModel>> getSurahTranslation(int surahNumber) async {
    // Return cached data if available
    if (_cachedTranslations.containsKey(surahNumber)) {
      return _cachedTranslations[surahNumber]!;
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/surah/$surahNumber/en.asad'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final surahResponse = SurahDetailResponse.fromJson(jsonData);
        if (surahResponse.data != null) {
          _cachedTranslations[surahNumber] = surahResponse.data!.ayahs;
          return surahResponse.data!.ayahs;
        }
        throw Exception('No translation data received for Surah $surahNumber');
      } else {
        throw Exception('Failed to load translation: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching translation: $e');
    }
  }

  /// Fetch Juz (Parah) detail with all ayahs
  Future<JuzDetailData> getJuzDetail(int juzNumber) async {
    // Return cached data if available
    if (_cachedJuzDetails.containsKey(juzNumber)) {
      return _cachedJuzDetails[juzNumber]!;
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/juz/$juzNumber/quran-uthmani'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final juzResponse = JuzDetailResponse.fromJson(jsonData);
        if (juzResponse.data != null) {
          _cachedJuzDetails[juzNumber] = juzResponse.data!;
          return juzResponse.data!;
        }
        throw Exception('No data received for Juz $juzNumber');
      } else {
        throw Exception('Failed to load Juz detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Juz detail: $e');
    }
  }

  /// Get paginated Surahs for lazy loading
  /// [page] - Page number (0-indexed)
  /// [pageSize] - Number of items per page
  Future<List<SurahModel>> getSurahsPaginated({
    required int page,
    int pageSize = 10,
  }) async {
    final allSurahs = await getSurahs();
    final startIndex = page * pageSize;
    final endIndex = (startIndex + pageSize).clamp(0, allSurahs.length);
    
    if (startIndex >= allSurahs.length) {
      return [];
    }
    
    // Simulate network delay for smooth loading
    await Future.delayed(const Duration(milliseconds: 200));
    
    return allSurahs.sublist(startIndex, endIndex);
  }

  /// Get paginated Parahs for lazy loading
  /// [page] - Page number (0-indexed)
  /// [pageSize] - Number of items per page
  Future<List<ParahModel>> getParahsPaginated({
    required int page,
    int pageSize = 10,
  }) async {
    final allParahs = await getParahs();
    final startIndex = page * pageSize;
    final endIndex = (startIndex + pageSize).clamp(0, allParahs.length);
    
    if (startIndex >= allParahs.length) {
      return [];
    }
    
    // Simulate network delay for smooth loading
    await Future.delayed(const Duration(milliseconds: 200));
    
    return allParahs.sublist(startIndex, endIndex);
  }

  /// Search Surahs by name
  Future<List<SurahModel>> searchSurahs(String query) async {
    final allSurahs = await getSurahs();
    if (query.isEmpty) return allSurahs;
    
    final lowerQuery = query.toLowerCase();
    return allSurahs.where((surah) {
      return surah.englishName.toLowerCase().contains(lowerQuery) ||
          surah.name.contains(query) ||
          surah.englishNameTranslation.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  /// Search Parahs by name
  Future<List<ParahModel>> searchParahs(String query) async {
    final allParahs = await getParahs();
    if (query.isEmpty) return allParahs;
    
    final lowerQuery = query.toLowerCase();
    return allParahs.where((parah) {
      return parah.englishName.toLowerCase().contains(lowerQuery) ||
          parah.arabicName.contains(query) ||
          parah.number.toString().contains(query);
    }).toList();
  }

  /// Clear cache to force fresh data fetch
  void clearCache() {
    _cachedSurahs = null;
    _cachedParahs = null;
    _cachedSurahDetails.clear();
    _cachedJuzDetails.clear();
    _cachedTranslations.clear();
  }
}

