/// Ayah Model
/// Represents a single verse from the Quran
class AyahModel {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final bool sajda;

  const AyahModel({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'] ?? 0,
      text: json['text'] ?? '',
      numberInSurah: json['numberInSurah'] ?? 0,
      juz: json['juz'] ?? 0,
      manzil: json['manzil'] ?? 0,
      page: json['page'] ?? 0,
      ruku: json['ruku'] ?? 0,
      hizbQuarter: json['hizbQuarter'] ?? 0,
      sajda: json['sajda'] is bool ? json['sajda'] : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
      'numberInSurah': numberInSurah,
      'juz': juz,
      'manzil': manzil,
      'page': page,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
      'sajda': sajda,
    };
  }
}

/// Translation Ayah Model
/// Contains both Arabic and English translation
class TranslationAyahModel {
  final int number;
  final int numberInSurah;
  final String arabicText;
  final String translationText;
  final int juz;

  const TranslationAyahModel({
    required this.number,
    required this.numberInSurah,
    required this.arabicText,
    required this.translationText,
    required this.juz,
  });
}

/// Surah Detail Response
class SurahDetailResponse {
  final int code;
  final String status;
  final SurahDetailData? data;

  const SurahDetailResponse({
    required this.code,
    required this.status,
    this.data,
  });

  factory SurahDetailResponse.fromJson(Map<String, dynamic> json) {
    return SurahDetailResponse(
      code: json['code'] ?? 0,
      status: json['status'] ?? '',
      data: json['data'] != null
          ? SurahDetailData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Surah Detail Data
class SurahDetailData {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final int numberOfAyahs;
  final List<AyahModel> ayahs;

  const SurahDetailData({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
    required this.ayahs,
  });

  factory SurahDetailData.fromJson(Map<String, dynamic> json) {
    return SurahDetailData(
      number: json['number'] ?? 0,
      name: json['name'] ?? '',
      englishName: json['englishName'] ?? '',
      englishNameTranslation: json['englishNameTranslation'] ?? '',
      revelationType: json['revelationType'] ?? '',
      numberOfAyahs: json['numberOfAyahs'] ?? 0,
      ayahs: (json['ayahs'] as List<dynamic>?)
              ?.map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// Juz (Parah) Detail Response
class JuzDetailResponse {
  final int code;
  final String status;
  final JuzDetailData? data;

  const JuzDetailResponse({
    required this.code,
    required this.status,
    this.data,
  });

  factory JuzDetailResponse.fromJson(Map<String, dynamic> json) {
    return JuzDetailResponse(
      code: json['code'] ?? 0,
      status: json['status'] ?? '',
      data: json['data'] != null
          ? JuzDetailData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Juz Detail Data
class JuzDetailData {
  final int number;
  final List<AyahModel> ayahs;

  const JuzDetailData({
    required this.number,
    required this.ayahs,
  });

  factory JuzDetailData.fromJson(Map<String, dynamic> json) {
    return JuzDetailData(
      number: json['number'] ?? 0,
      ayahs: (json['ayahs'] as List<dynamic>?)
              ?.map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
