/// Surah Model
/// Represents a single Surah from the Quran
class SurahModel {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;

  const SurahModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      number: json['number'] ?? 0,
      name: json['name'] ?? '',
      englishName: json['englishName'] ?? '',
      englishNameTranslation: json['englishNameTranslation'] ?? '',
      numberOfAyahs: json['numberOfAyahs'] ?? 0,
      revelationType: json['revelationType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'numberOfAyahs': numberOfAyahs,
      'revelationType': revelationType,
    };
  }
}

/// API Response wrapper for Surah list
class SurahListResponse {
  final int code;
  final String status;
  final List<SurahModel> data;

  const SurahListResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory SurahListResponse.fromJson(Map<String, dynamic> json) {
    return SurahListResponse(
      code: json['code'] ?? 0,
      status: json['status'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => SurahModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
