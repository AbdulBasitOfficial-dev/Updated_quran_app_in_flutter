import '../models/kalma_model.dart';

/// Service for Six Kalmas data
/// Provides authentic Six Kalmas with pagination support
class KalmaService {
  // Singleton pattern
  static final KalmaService _instance = KalmaService._internal();
  factory KalmaService() => _instance;
  KalmaService._internal();

  // Cache for Kalmas
  List<KalmaModel>? _cachedKalmas;

  /// Get all Six Kalmas
  Future<List<KalmaModel>> getAllKalmas() async {
    if (_cachedKalmas != null) {
      return _cachedKalmas!;
    }

    _cachedKalmas = _getKalmasData();
    return _cachedKalmas!;
  }

  /// Get paginated Kalmas
  Future<List<KalmaModel>> getKalmasPaginated({
    required int page,
    int pageSize = 10,
  }) async {
    if (_cachedKalmas == null) {
      await getAllKalmas();
    }

    final startIndex = page * pageSize;
    final endIndex = (startIndex + pageSize).clamp(0, _cachedKalmas!.length);

    if (startIndex >= _cachedKalmas!.length) {
      return [];
    }

    // Simulate network delay for smooth loading
    await Future.delayed(const Duration(milliseconds: 200));

    return _cachedKalmas!.sublist(startIndex, endIndex);
  }

  /// Static data for the Six Kalmas (authentic Islamic texts)
  List<KalmaModel> _getKalmasData() {
    return const [
      KalmaModel(
        number: 1,
        title: 'First Kalma (Tayyab)',
        arabicText: 'لَا إِلٰهَ إِلَّا اللهُ مُحَمَّدٌ رَسُولُ اللهِ',
        transliteration: 'Laa ilaaha illal-Laahu Muhammadur-Rasoolul-Laah',
        englishMeaning:
            'There is no God but Allah, Muhammad is the Messenger of Allah.',
      ),
      KalmaModel(
        number: 2,
        title: 'Second Kalma (Shahadat)',
        arabicText:
            'أَشْهَدُ أَنْ لَّا إِلٰهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيْكَ لَهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
        transliteration:
            'Ash-hadu al-laa ilaaha illal-Laahu wahdahu laa shareeka lahu wa ash-hadu anna Muhammadan \'abduhu wa Rasooluh',
        englishMeaning:
            'I bear witness that there is no God but Allah, Who is alone and has no partner, and I bear witness that Muhammad is His servant and Messenger.',
      ),
      KalmaModel(
        number: 3,
        title: 'Third Kalma (Tamjeed)',
        arabicText:
            'سُبْحَانَ اللهِ وَالْحَمْدُ لِلَّهِ وَلَا إِلٰهَ إِلَّا اللهُ وَاللهُ أَكْبَرُ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ الْعَلِيِّ الْعَظِيْمِ',
        transliteration:
            'Subhaanal-laahi wal-hamdu lillaahi wa laa ilaaha illal-laahu wal-laahu akbar. Wa laa hawla wa laa quwwata illaa billaahil-\'Aliyyil-\'Azeem',
        englishMeaning:
            'Glory be to Allah, and praise be to Allah, and there is no God but Allah, and Allah is the Greatest. And there is no power and no strength except with Allah, the Most High, the Most Great.',
      ),
      KalmaModel(
        number: 4,
        title: 'Fourth Kalma (Tawheed)',
        arabicText:
            'لَا إِلٰهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيْكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ يُحْيِي وَيُمِيتُ وَهُوَ حَيٌّ لَا يَمُوتُ، بِيَدِهِ الْخَيْرُ وَهُوَ عَلٰى كُلِّ شَيْءٍ قَدِيرٌ',
        transliteration:
            'Laa ilaaha illal-laahu wahdahu laa shareeka lahu, lahul-mulku wa lahul-hamdu yuhyee wa yumeetu wa huwa hayyun laa yamootu, biyadihil-khayru wa huwa \'alaa kulli shay\'in qadeer',
        englishMeaning:
            'There is none worthy of worship except Allah. He is alone and has no partner. To Him belongs the Kingdom and for Him is all praise. He gives life and causes death. In His hand is all good and He has power over everything.',
      ),
      KalmaModel(
        number: 5,
        title: 'Fifth Kalma (Astaghfar)',
        arabicText:
            'أَسْتَغْفِرُ اللهَ رَبِّي مِنْ كُلِّ ذَنْبٍ أَذْنَبْتُهُ عَمَدًا أَوْ خَطَأً سِرًّا أَوْ عَلَانِيَةً وَأَتُوبُ إِلَيْهِ مِنَ الذَّنْبِ الَّذِي أَعْلَمُ وَمِنَ الذَّنْبِ الَّذِي لَا أَعْلَمُ إِنَّكَ أَنْتَ عَلَّامُ الْغُيُوبِ وَسَتَّارُ الْعُيُوبِ وَغَفَّارُ الذُّنُوبِ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ الْعَلِيِّ الْعَظِيمِ',
        transliteration:
            'Astaghfirul-laaha Rabbi min kulli zambin aznabtuhu \'amadan aw khata\'an sirran aw \'alaaniyatan wa atoobu ilayhi minaz-zambil-lazee a\'lamu wa minaz-zambil-lazee laa a\'lamu innaka anta \'allaamul-ghuyoobi wa sattaarul-\'uyoobi wa ghaffaaruz-zunoobi wa laa hawla wa laa quwwata illaa billaahil-\'Aliyyil-\'Azeem',
        englishMeaning:
            'I seek forgiveness from Allah, my Lord, from every sin I committed knowingly or unknowingly, secretly or openly, and I turn to Him from the sin that I know and from the sin that I do not know. Certainly You are the Knower of the hidden and the Concealer of mistakes and the Forgiver of sins, and there is no power and no strength except with Allah, the Most High, the Most Great.',
      ),
      KalmaModel(
        number: 6,
        title: 'Sixth Kalma (Radde Kufr)',
        arabicText:
            'اَللّٰهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ أَنْ أُشْرِكَ بِكَ شَيْئًا وَأَنَا أَعْلَمُ وَأَسْتَغْفِرُكَ لِمَا لَا أَعْلَمُ إِنَّكَ أَنْتَ عَلَّامُ الْغُيُوبِ تُبْتُ عَنْهُ وَتَبَرَّأْتُ مِنْ كُلِّ دِينٍ سِوَى الْإِسْلَامِ وَأَسْلَمْتُ وَأَقُولُ لَا إِلٰهَ إِلَّا اللهُ مُحَمَّدٌ رَسُولُ اللهِ',
        transliteration:
            'Allaahumma innee a\'oozu bika min an ushrika bika shay\'an wa ana a\'lamu wa astaghfiruka limaa laa a\'lamu innaka anta \'allaamul-ghuyoobi tubtu \'anhu wa tabarra\'tu min kulli deenin siwal-islaami wa aslamtu wa aqoolu laa ilaaha illal-laahu Muhammadur-Rasoolul-laah',
        englishMeaning:
            'O Allah! I seek refuge in You from associating anything with You knowingly, and I seek Your forgiveness for what I do not know. Indeed, You are the Knower of the unseen. I repent from it and I disassociate myself from every religion other than Islam, and I submit myself to You, and I say: There is no God but Allah, Muhammad is the Messenger of Allah.',
      ),
    ];
  }

  /// Clear cache
  void clearCache() {
    _cachedKalmas = null;
  }
}
