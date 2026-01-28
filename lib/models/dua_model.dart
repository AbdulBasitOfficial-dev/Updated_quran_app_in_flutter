/// Dua Model for Masnoon Duas
/// Represents a single Dua with Arabic text, transliteration, meaning, and reference

class DuaModel {
  final int number;
  final String title;
  final String arabicText;
  final String transliteration;
  final String englishMeaning;
  final String? reference;

  const DuaModel({
    required this.number,
    required this.title,
    required this.arabicText,
    required this.transliteration,
    required this.englishMeaning,
    this.reference,
  });

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'title': title,
      'arabicText': arabicText,
      'transliteration': transliteration,
      'englishMeaning': englishMeaning,
      'reference': reference,
    };
  }
}
