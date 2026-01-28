/// Name Model for Allah's Names and Muhammad's Names
/// Used by both Asma Ul Husna and Muhammad Names screens

class NameModel {
  final int number;
  final String arabicName;
  final String transliteration;
  final String englishMeaning;

  const NameModel({
    required this.number,
    required this.arabicName,
    required this.transliteration,
    required this.englishMeaning,
  });

  /// Factory constructor for Allah's Names API response
  factory NameModel.fromAlHusnaJson(Map<String, dynamic> json) {
    return NameModel(
      number: json['number'] ?? 0,
      arabicName: json['name'] ?? '',
      transliteration: json['transliteration'] ?? '',
      englishMeaning: json['en']?['meaning'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'arabicName': arabicName,
      'transliteration': transliteration,
      'englishMeaning': englishMeaning,
    };
  }
}

/// API Response wrapper for Names
class NamesApiResponse {
  final int code;
  final String status;
  final List<NameModel> data;

  const NamesApiResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory NamesApiResponse.fromJson(Map<String, dynamic> json) {
    return NamesApiResponse(
      code: json['code'] ?? 0,
      status: json['status'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => NameModel.fromAlHusnaJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
