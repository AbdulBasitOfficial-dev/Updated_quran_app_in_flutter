import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/name_model.dart';

/// API Service for Islamic Names
/// Fetches Allah's 99 Names and Muhammad's Names from AlAdhan API
class NamesApiService {
  static const String _baseUrl = 'https://api.aladhan.com/v1';

  // Singleton pattern
  static final NamesApiService _instance = NamesApiService._internal();
  factory NamesApiService() => _instance;
  NamesApiService._internal();

  // Cache for API responses
  List<NameModel>? _cachedAllahNames;
  List<NameModel>? _cachedMuhammadNames;

  /// Fetch Allah's Names with pagination
  /// [startIndex] - Starting index (1-based, max 99)
  /// [count] - Number of names to fetch (default 15)
  Future<List<NameModel>> getAllahNames({
    required int startIndex,
    int count = 15,
  }) async {
    // If we have cached data, return paginated slice
    if (_cachedAllahNames != null) {
      final start = startIndex - 1;
      final end = (start + count).clamp(0, _cachedAllahNames!.length);
      if (start >= _cachedAllahNames!.length) return [];
      return _cachedAllahNames!.sublist(start, end);
    }

    // Generate comma-separated list of numbers to fetch
    final endIndex = (startIndex + count - 1).clamp(1, 99);
    final ids = List.generate(
      endIndex - startIndex + 1,
      (i) => startIndex + i,
    ).join(',');

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/asmaAlHusna/$ids'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final apiResponse = NamesApiResponse.fromJson(jsonData);
        return apiResponse.data;
      } else {
        throw Exception('Failed to load Allah Names: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Allah Names: $e');
    }
  }

  /// Fetch all Allah's Names (for caching)
  Future<List<NameModel>> getAllAllahNames() async {
    if (_cachedAllahNames != null) {
      return _cachedAllahNames!;
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/asmaAlHusna'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final apiResponse = NamesApiResponse.fromJson(jsonData);
        _cachedAllahNames = apiResponse.data;
        return _cachedAllahNames!;
      } else {
        throw Exception('Failed to load Allah Names: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Allah Names: $e');
    }
  }

  /// Get paginated Allah's Names from cache
  Future<List<NameModel>> getAllahNamesPaginated({
    required int page,
    int pageSize = 15,
  }) async {
    // Ensure cache is loaded
    if (_cachedAllahNames == null) {
      await getAllAllahNames();
    }

    final startIndex = page * pageSize;
    final endIndex = (startIndex + pageSize).clamp(
      0,
      _cachedAllahNames!.length,
    );

    if (startIndex >= _cachedAllahNames!.length) {
      return [];
    }

    // Simulate network delay for smooth loading
    await Future.delayed(const Duration(milliseconds: 200));

    return _cachedAllahNames!.sublist(startIndex, endIndex);
  }

  /// Get Muhammad's Names (static data since API may not be available)
  Future<List<NameModel>> getMuhammadNames() async {
    if (_cachedMuhammadNames != null) {
      return _cachedMuhammadNames!;
    }

    // Using authentic names of Prophet Muhammad ﷺ
    _cachedMuhammadNames = _getMuhammadNamesData();
    return _cachedMuhammadNames!;
  }

  /// Get paginated Muhammad's Names
  Future<List<NameModel>> getMuhammadNamesPaginated({
    required int page,
    int pageSize = 15,
  }) async {
    if (_cachedMuhammadNames == null) {
      await getMuhammadNames();
    }

    final startIndex = page * pageSize;
    final endIndex = (startIndex + pageSize).clamp(
      0,
      _cachedMuhammadNames!.length,
    );

    if (startIndex >= _cachedMuhammadNames!.length) {
      return [];
    }

    // Simulate network delay for smooth loading
    await Future.delayed(const Duration(milliseconds: 200));

    return _cachedMuhammadNames!.sublist(startIndex, endIndex);
  }

  /// Static data for Prophet Muhammad's ﷺ Names
  List<NameModel> _getMuhammadNamesData() {
    return const [
      NameModel(
        number: 1,
        arabicName: 'مُحَمَّد',
        transliteration: 'Muhammad',
        englishMeaning: 'The Praised One',
      ),
      NameModel(
        number: 2,
        arabicName: 'أَحْمَد',
        transliteration: 'Ahmad',
        englishMeaning: 'The Most Praiseworthy',
      ),
      NameModel(
        number: 3,
        arabicName: 'حَامِد',
        transliteration: 'Hamid',
        englishMeaning: 'The One Who Praises',
      ),
      NameModel(
        number: 4,
        arabicName: 'مَحْمُود',
        transliteration: 'Mahmud',
        englishMeaning: 'The Praised',
      ),
      NameModel(
        number: 5,
        arabicName: 'قَاسِم',
        transliteration: 'Qasim',
        englishMeaning: 'The Distributor',
      ),
      NameModel(
        number: 6,
        arabicName: 'عَاقِب',
        transliteration: 'Aqib',
        englishMeaning: 'The Last Prophet',
      ),
      NameModel(
        number: 7,
        arabicName: 'فَاتِح',
        transliteration: 'Fatih',
        englishMeaning: 'The Opener',
      ),
      NameModel(
        number: 8,
        arabicName: 'شَاهِد',
        transliteration: 'Shahid',
        englishMeaning: 'The Witness',
      ),
      NameModel(
        number: 9,
        arabicName: 'مُبَشِّر',
        transliteration: 'Mubashir',
        englishMeaning: 'The Bringer of Good News',
      ),
      NameModel(
        number: 10,
        arabicName: 'نَذِير',
        transliteration: 'Nadhir',
        englishMeaning: 'The Warner',
      ),
      NameModel(
        number: 11,
        arabicName: 'رَحْمَة',
        transliteration: 'Rahmat',
        englishMeaning: 'The Mercy',
      ),
      NameModel(
        number: 12,
        arabicName: 'نَبِي',
        transliteration: 'Nabi',
        englishMeaning: 'The Prophet',
      ),
      NameModel(
        number: 13,
        arabicName: 'رَسُول',
        transliteration: 'Rasul',
        englishMeaning: 'The Messenger',
      ),
      NameModel(
        number: 14,
        arabicName: 'أُمِّي',
        transliteration: 'Ummi',
        englishMeaning: 'The Unlettered',
      ),
      NameModel(
        number: 15,
        arabicName: 'مُخْتَار',
        transliteration: 'Mukhtar',
        englishMeaning: 'The Chosen',
      ),
      NameModel(
        number: 16,
        arabicName: 'مُصْطَفَى',
        transliteration: 'Mustafa',
        englishMeaning: 'The Selected',
      ),
      NameModel(
        number: 17,
        arabicName: 'حَبِيب',
        transliteration: 'Habib',
        englishMeaning: 'The Beloved',
      ),
      NameModel(
        number: 18,
        arabicName: 'خَلِيل',
        transliteration: 'Khalil',
        englishMeaning: 'The Friend',
      ),
      NameModel(
        number: 19,
        arabicName: 'صَفِي',
        transliteration: 'Safi',
        englishMeaning: 'The Pure',
      ),
      NameModel(
        number: 20,
        arabicName: 'نَجِي',
        transliteration: 'Naji',
        englishMeaning: 'The Intimate Friend',
      ),
      NameModel(
        number: 21,
        arabicName: 'طَه',
        transliteration: 'Taha',
        englishMeaning: 'Taha',
      ),
      NameModel(
        number: 22,
        arabicName: 'يَس',
        transliteration: 'Yasin',
        englishMeaning: 'Yasin',
      ),
      NameModel(
        number: 23,
        arabicName: 'هَادِي',
        transliteration: 'Hadi',
        englishMeaning: 'The Guide',
      ),
      NameModel(
        number: 24,
        arabicName: 'مَهْدِي',
        transliteration: 'Mahdi',
        englishMeaning: 'The Guided',
      ),
      NameModel(
        number: 25,
        arabicName: 'سَيِّد',
        transliteration: 'Sayyid',
        englishMeaning: 'The Master',
      ),
      NameModel(
        number: 26,
        arabicName: 'سِرَاج',
        transliteration: 'Siraj',
        englishMeaning: 'The Lamp',
      ),
      NameModel(
        number: 27,
        arabicName: 'مُنِير',
        transliteration: 'Munir',
        englishMeaning: 'The Illuminating',
      ),
      NameModel(
        number: 28,
        arabicName: 'دَاعِي',
        transliteration: 'Da\'i',
        englishMeaning: 'The Caller',
      ),
      NameModel(
        number: 29,
        arabicName: 'بَشِير',
        transliteration: 'Bashir',
        englishMeaning: 'The Bearer of Good Tidings',
      ),
      NameModel(
        number: 30,
        arabicName: 'أَمِين',
        transliteration: 'Amin',
        englishMeaning: 'The Trustworthy',
      ),
      NameModel(
        number: 31,
        arabicName: 'صَادِق',
        transliteration: 'Sadiq',
        englishMeaning: 'The Truthful',
      ),
      NameModel(
        number: 32,
        arabicName: 'خَاتَم',
        transliteration: 'Khatam',
        englishMeaning: 'The Seal of Prophets',
      ),
      NameModel(
        number: 33,
        arabicName: 'عَبْدُ اللَّه',
        transliteration: 'Abdullah',
        englishMeaning: 'Servant of Allah',
      ),
    ];
  }

  /// Clear cache
  void clearCache() {
    _cachedAllahNames = null;
    _cachedMuhammadNames = null;
  }
}
