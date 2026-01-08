
# 📖 Quran Pak App (Flutter)
A modern, pixel-perfect Quran Pak mobile application built using **Flutter**.  
The app provides an elegant and smooth reading experience with Arabic Quran text, English translation, lazy loading for performance, and Dark/Light mode support.

---

## ✨ Features

- 📜 Complete Quran (Surah & Parah/Juz)
- 🔍 Surah List & Parah List
- 📖 Surah Detail & Parah Detail Pages
- 🕌 Authentic Arabic Quran Text (Uthmani Script)
- 🌍 English Translation (Asad)
- ⚡ Lazy Loading (No UI freeze or crash)
- 🌙 Dark Mode / ☀️ Light Mode toggle
- 💾 Theme preference saved locally
- 📱 Fully responsive & pixel-perfect UI (Figma based)

---

## 📱 Screens Overview

- Splash Screen  
- Home Screen  
- Quran Section  
  - Surah List  
  - Parah (Juz) List  
- Surah Detail (Arabic + English)  
- Parah Detail (Arabic + English)  
- Side Drawer with Theme Toggle  

---

## 🌐 Quran API Used (Free)

**AlQuran Cloud API**  
No authentication required.

- Surah List  
```

[https://api.alquran.cloud/v1/surah](https://api.alquran.cloud/v1/surah)

```

- Surah Detail (Arabic + English)
```

[https://api.alquran.cloud/v1/surah/{surahNumber}/editions/quran-uthmani,en.asad](https://api.alquran.cloud/v1/surah/{surahNumber}/editions/quran-uthmani,en.asad)

```

- Parah (Juz) Detail (Arabic + English)
```

[https://api.alquran.cloud/v1/juz/{juzNumber}/editions/quran-uthmani,en.asad](https://api.alquran.cloud/v1/juz/{juzNumber}/editions/quran-uthmani,en.asad)

```

---

## ⚡ Performance Optimization

- Uses `ListView.builder`
- Chunk-based lazy loading for Ayahs
- Smooth scrolling
- Memory efficient rendering
- Prevents UI lag & crashes

---

## 🎨 Theme Support

- Light Mode
- Dark Mode
- Theme toggle available in side drawer
- Theme preference saved using `SharedPreferences`

---

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **REST APIs**
- **Provider** (state management)
- **SharedPreferences**

---

## 📂 Project Structure

```

lib/
│── main.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── surah_list_screen.dart
│   ├── parah_list_screen.dart
│   ├── surah_detail_screen.dart
│   └── parah_detail_screen.dart
│
├── widgets/
│   ├── ayah_item.dart
│   ├── surah_card.dart
│   └── app_drawer.dart
│
├── services/
│   └── quran_api_service.dart
│
├── models/
│   └── ayah_model.dart
│
├── providers/
│   └── theme_provider.dart
│
└── theme/
└── app_theme.dart

````

---

## 🚀 How to Run the Project

1. Clone the repository
   ```bash
   git clone <repo-url>
````

2. Install dependencies

   ```bash
   flutter pub get
   ```

3. Run the app

   ```bash
   flutter run
   ```

---

## 📦 Build APK

### Debug APK

```bash
flutter build apk --debug
```

### Release APK

```bash
flutter build apk --release
```

APK location:

```
build/app/outputs/flutter-apk/
```

---

## 🧠 Future Enhancements

* 🔊 Audio recitation
* ⭐ Bookmarks & last read
* 📖 Tafsir
* 🌐 Multiple translations
* 📥 Offline Quran support

---

## 🤝 Contribution

Contributions, issues, and feature requests are welcome.

---

## 🧑‍💻 Developer

Built with ❤️ using Flutter
For learning, educational, and personal use.

---

## 📜 License

This project is for educational purposes.
Quran text and translations belong to their respective sources.

```


