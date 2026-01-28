/// Kalma Model for Six Kalmas
/// Represents a single Kalma with Arabic text, transliteration, and meaning

class KalmaModel {
  final int number;
  final String title;
  final String arabicText;
  final String transliteration;
  final String englishMeaning;

  const KalmaModel({
    required this.number,
    required this.title,
    required this.arabicText,
    required this.transliteration,
    required this.englishMeaning,
  });

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'title': title,
      'arabicText': arabicText,
      'transliteration': transliteration,
      'englishMeaning': englishMeaning,
    };
  }
}
