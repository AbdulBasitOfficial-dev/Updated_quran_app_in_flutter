import '../models/dua_model.dart';

/// Service for Masnoon Duas data
/// Provides authentic Masnoon Duas with pagination support
class DuaService {
  // Singleton pattern
  static final DuaService _instance = DuaService._internal();
  factory DuaService() => _instance;
  DuaService._internal();

  // Cache for Duas
  List<DuaModel>? _cachedDuas;

  /// Get all Masnoon Duas
  Future<List<DuaModel>> getAllDuas() async {
    if (_cachedDuas != null) {
      return _cachedDuas!;
    }

    _cachedDuas = _getDuasData();
    return _cachedDuas!;
  }

  /// Get paginated Duas
  Future<List<DuaModel>> getDuasPaginated({
    required int page,
    int pageSize = 8,
  }) async {
    if (_cachedDuas == null) {
      await getAllDuas();
    }

    final startIndex = page * pageSize;
    final endIndex = (startIndex + pageSize).clamp(0, _cachedDuas!.length);

    if (startIndex >= _cachedDuas!.length) {
      return [];
    }

    // Simulate network delay for smooth loading
    await Future.delayed(const Duration(milliseconds: 200));

    return _cachedDuas!.sublist(startIndex, endIndex);
  }

  /// Static data for Masnoon Duas (authentic Islamic texts)
  List<DuaModel> _getDuasData() {
    return const [
      DuaModel(
        number: 1,
        title: 'Dua Before Sleeping',
        arabicText: 'بِاسْمِكَ اللّٰهُمَّ أَمُوتُ وَأَحْيَا',
        transliteration: 'Bismika Allaahumma amootu wa ahyaa',
        englishMeaning: 'In Your name, O Allah, I die and I live.',
        reference: 'Bukhari',
      ),
      DuaModel(
        number: 2,
        title: 'Dua After Waking Up',
        arabicText:
            'اَلْحَمْدُ لِلّٰهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
        transliteration:
            'Alhamdu lillaahil-lazee ahyaanaa ba\'da maa amaatanaa wa ilayhin-nushoor',
        englishMeaning:
            'All praise is for Allah who gave us life after causing us to die, and unto Him is the resurrection.',
        reference: 'Bukhari',
      ),
      DuaModel(
        number: 3,
        title: 'Dua Before Eating',
        arabicText: 'بِسْمِ اللهِ وَعَلَى بَرَكَةِ اللهِ',
        transliteration: 'Bismillaahi wa \'alaa barakatillaah',
        englishMeaning: 'In the name of Allah and with the blessings of Allah.',
        reference: 'Abu Dawud',
      ),
      DuaModel(
        number: 4,
        title: 'Dua After Eating',
        arabicText:
            'اَلْحَمْدُ لِلّٰهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ',
        transliteration:
            'Alhamdu lillaahil-lazee at\'amanaa wa saqaanaa wa ja\'alanaa muslimeen',
        englishMeaning:
            'All praise is for Allah who fed us and gave us drink, and made us Muslims.',
        reference: 'Abu Dawud, Tirmidhi',
      ),
      DuaModel(
        number: 5,
        title: 'Dua Before Entering Bathroom',
        arabicText:
            'اَللّٰهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبُثِ وَالْخَبَائِثِ',
        transliteration:
            'Allaahumma innee a\'oozu bika minal-khubuthi wal-khabaa\'ith',
        englishMeaning:
            'O Allah, I seek refuge in You from male and female devils.',
        reference: 'Bukhari, Muslim',
      ),
      DuaModel(
        number: 6,
        title: 'Dua After Leaving Bathroom',
        arabicText: 'غُفْرَانَكَ',
        transliteration: 'Ghufraanak',
        englishMeaning: 'I seek Your forgiveness.',
        reference: 'Abu Dawud, Tirmidhi',
      ),
      DuaModel(
        number: 7,
        title: 'Dua Before Entering Mosque',
        arabicText: 'اَللّٰهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
        transliteration: 'Allaahummaf-tah lee abwaaba rahmatik',
        englishMeaning: 'O Allah, open for me the doors of Your mercy.',
        reference: 'Muslim',
      ),
      DuaModel(
        number: 8,
        title: 'Dua When Leaving Mosque',
        arabicText: 'اَللّٰهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ',
        transliteration: 'Allaahumma innee as\'aluka min fadlik',
        englishMeaning: 'O Allah, I ask You from Your bounty.',
        reference: 'Muslim',
      ),
      DuaModel(
        number: 9,
        title: 'Dua When Leaving Home',
        arabicText:
            'بِسْمِ اللهِ تَوَكَّلْتُ عَلَى اللهِ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ',
        transliteration:
            'Bismillaahi tawakkaltu \'alal-laahi wa laa hawla wa laa quwwata illaa billaah',
        englishMeaning:
            'In the name of Allah, I place my trust in Allah, and there is no might nor power except with Allah.',
        reference: 'Abu Dawud, Tirmidhi',
      ),
      DuaModel(
        number: 10,
        title: 'Dua When Entering Home',
        arabicText:
            'اَللّٰهُمَّ إِنِّي أَسْأَلُكَ خَيْرَ الْمَوْلِجِ وَخَيْرَ الْمَخْرَجِ بِسْمِ اللهِ وَلَجْنَا وَبِسْمِ اللهِ خَرَجْنَا وَعَلَى اللهِ رَبِّنَا تَوَكَّلْنَا',
        transliteration:
            'Allaahumma innee as\'aluka khayral-mawliji wa khayral-makhraji bismillaahi walajna wa bismillaahi kharajna wa \'alallaahi rabbinaa tawakkalnaa',
        englishMeaning:
            'O Allah, I ask You for the best entrance and the best exit. In the name of Allah we enter, in the name of Allah we leave, and upon Allah our Lord we rely.',
        reference: 'Abu Dawud',
      ),
      DuaModel(
        number: 11,
        title: 'Dua When Wearing New Clothes',
        arabicText:
            'اَلْحَمْدُ لِلّٰهِ الَّذِي كَسَانِي هٰذَا وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ',
        transliteration:
            'Alhamdu lillaahil-lazee kasaanee haazaa wa razaqaneehi min ghayri hawlin minnee wa laa quwwah',
        englishMeaning:
            'All praise is for Allah who clothed me with this and provided it for me without any power or strength from me.',
        reference: 'Abu Dawud, Tirmidhi',
      ),
      DuaModel(
        number: 12,
        title: 'Dua When Looking in Mirror',
        arabicText: 'اَللّٰهُمَّ أَنْتَ حَسَّنْتَ خَلْقِي فَحَسِّنْ خُلُقِي',
        transliteration: 'Allaahumma anta hassanta khalqee fa-hassin khuluqee',
        englishMeaning:
            'O Allah, You have made my creation beautiful, so make my character beautiful too.',
        reference: 'Ahmad',
      ),
      DuaModel(
        number: 13,
        title: 'Dua Before Traveling',
        arabicText:
            'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هٰذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ',
        transliteration:
            'Subhaanal-lazee sakh-khara lanaa haazaa wa maa kunnaa lahu muqrineen wa innaa ilaa rabbinaa lamunqaliboon',
        englishMeaning:
            'Glory be to Him Who has subjected this to us, and we could never have it by our efforts, and verily to our Lord we will return.',
        reference: 'Muslim, Tirmidhi',
      ),
      DuaModel(
        number: 14,
        title: 'Dua When It Rains',
        arabicText: 'اَللّٰهُمَّ صَيِّبًا نَافِعًا',
        transliteration: 'Allaahumma sayyiban naafi\'aa',
        englishMeaning: 'O Allah, make it a beneficial rain.',
        reference: 'Bukhari',
      ),
      DuaModel(
        number: 15,
        title: 'Dua When Hearing Thunder',
        arabicText:
            'سُبْحَانَ الَّذِي يُسَبِّحُ الرَّعْدُ بِحَمْدِهِ وَالْمَلَائِكَةُ مِنْ خِيفَتِهِ',
        transliteration:
            'Subhaanal-lazee yusabbihur-ra\'du bihamdihi wal-malaa\'ikatu min kheefatih',
        englishMeaning:
            'Glory be to Him Whom thunder glorifies with His praise, and the angels too out of fear of Him.',
        reference: 'Muwatta Malik',
      ),
      DuaModel(
        number: 16,
        title: 'Dua When Facing Difficulty',
        arabicText:
            'لَا إِلٰهَ إِلَّا اللهُ الْعَظِيمُ الْحَلِيمُ لَا إِلٰهَ إِلَّا اللهُ رَبُّ الْعَرْشِ الْعَظِيمِ لَا إِلٰهَ إِلَّا اللهُ رَبُّ السَّمٰوَاتِ وَرَبُّ الْأَرْضِ وَرَبُّ الْعَرْشِ الْكَرِيمِ',
        transliteration:
            'Laa ilaaha illal-laahul-\'Azeemul-Haleem. Laa ilaaha illal-laahu Rabbul-\'Arshil-\'Azeem. Laa ilaaha illal-laahu Rabbus-samaawaati wa Rabbul-ardi wa Rabbul-\'Arshil-Kareem',
        englishMeaning:
            'There is no God but Allah, the Magnificent, the Forbearing. There is no God but Allah, Lord of the Magnificent Throne. There is no God but Allah, Lord of the heavens, Lord of the earth, and Lord of the Noble Throne.',
        reference: 'Bukhari, Muslim',
      ),
      DuaModel(
        number: 17,
        title: 'Dua When Angry',
        arabicText: 'أَعُوذُ بِاللهِ مِنَ الشَّيْطَانِ الرَّجِيمِ',
        transliteration: 'A\'oozu billaahi minash-shaytaanir-rajeem',
        englishMeaning: 'I seek refuge in Allah from the accursed Satan.',
        reference: 'Bukhari, Muslim',
      ),
      DuaModel(
        number: 18,
        title: 'Dua When Feeling Pain',
        arabicText:
            'أَعُوذُ بِعِزَّةِ اللهِ وَقُدْرَتِهِ مِنْ شَرِّ مَا أَجِدُ وَأُحَاذِرُ',
        transliteration:
            'A\'oozu bi\'izzatillaahi wa qudratihi min sharri maa ajidu wa uhaazir',
        englishMeaning:
            'I seek refuge in Allah\'s might and power from the evil of what I feel and what I fear.',
        reference: 'Muslim',
      ),
      DuaModel(
        number: 19,
        title: 'Dua For Parents',
        arabicText:
            'رَبِّ اغْفِرْ لِي وَلِوَالِدَيَّ وَلِلْمُؤْمِنِينَ يَوْمَ يَقُومُ الْحِسَابُ',
        transliteration:
            'Rabbigh-fir lee wa liwaalidayya wa lil-mu\'mineena yawma yaqoomul-hisaab',
        englishMeaning:
            'O my Lord! Forgive me and my parents and the believers on the Day when the reckoning will be established.',
        reference: 'Quran 14:41',
      ),
      DuaModel(
        number: 20,
        title: 'Dua For Protection',
        arabicText:
            'بِسْمِ اللهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
        transliteration:
            'Bismillaahil-lazee laa yadurru ma\'as-mihi shay\'un fil-ardi wa laa fis-samaa\'i wa huwas-Samee\'ul-\'Aleem',
        englishMeaning:
            'In the name of Allah, with Whose name nothing is harmed on earth nor in the heavens, and He is the All-Hearing, the All-Knowing.',
        reference: 'Abu Dawud, Tirmidhi',
      ),
      DuaModel(
        number: 21,
        title: 'Dua Before Studying',
        arabicText:
            'اَللّٰهُمَّ انْفَعْنِي بِمَا عَلَّمْتَنِي وَعَلِّمْنِي مَا يَنْفَعُنِي وَزِدْنِي عِلْمًا',
        transliteration:
            'Allaahum-manfa\'nee bimaa \'allamtanee wa \'allimnee maa yanfa\'unee wa zidnee \'ilmaa',
        englishMeaning:
            'O Allah, benefit me with what You have taught me, teach me what will benefit me, and increase me in knowledge.',
        reference: 'Tirmidhi, Ibn Majah',
      ),
      DuaModel(
        number: 22,
        title: 'Dua For Forgiveness',
        arabicText:
            'أَسْتَغْفِرُ اللهَ الْعَظِيمَ الَّذِي لَا إِلٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَأَتُوبُ إِلَيْهِ',
        transliteration:
            'Astaghfirul-laahal-\'Azeemal-lazee laa ilaaha illaa huwal-Hayyul-Qayyoomu wa atoobu ilayh',
        englishMeaning:
            'I seek forgiveness from Allah, the Magnificent, besides Whom there is no God, the Ever-Living, the Sustainer, and I repent to Him.',
        reference: 'Abu Dawud, Tirmidhi',
      ),
    ];
  }

  /// Clear cache
  void clearCache() {
    _cachedDuas = null;
  }
}
