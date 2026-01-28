# 📖 NOOR-UL-QURAN - Islamic Mobile Application
## Comprehensive Project Report

---

# 📋 TABLE OF CONTENTS

1. [Project Overview](#1-project-overview)
2. [Technology Stack](#2-technology-stack)
3. [Project Architecture](#3-project-architecture)
4. [Features & Modules](#4-features--modules)
5. [Dependencies & Packages](#5-dependencies--packages)
6. [File Structure](#6-file-structure)
7. [Screens Description](#7-screens-description)
8. [API Integration](#8-api-integration)
9. [State Management](#9-state-management)
10. [Key Concepts Used](#10-key-concepts-used)
11. [How to Run](#11-how-to-run)
12. [Viva Preparation Q&A](#12-viva-preparation-qa)

---

# 1. PROJECT OVERVIEW

## 📱 Project Name
**Noor-Ul-Quran** (نور القرآن)

## 📝 Description
Noor-Ul-Quran is a comprehensive Islamic mobile application developed using Flutter framework. The app provides Muslims with easy access to the Holy Quran, Islamic prayers (Duas), Six Kalmas, and the beautiful names of Allah and Prophet Muhammad ﷺ.

## 🎯 Objectives
- Provide easy access to Quran Pak (Surahs and Parahs)
- Display 99 Names of Allah (Asma Ul Husna)
- Display Names of Prophet Muhammad ﷺ
- Provide Six Kalmas with Arabic text, transliteration, and meaning
- Provide Masnoon Duas for daily life
- Beautiful Islamic-themed UI with dark/light mode support

## 👤 Target Users
- Muslims who want to read Quran on mobile
- Students learning Islamic prayers and Kalmas
- Anyone interested in Islamic knowledge

## 📅 Project Version
- **Version**: 1.0.0+1
- **SDK**: Flutter 3.9.2+
- **Platform**: Android & iOS

---

# 2. TECHNOLOGY STACK

| Technology | Purpose |
|------------|---------|
| **Flutter** | Cross-platform mobile app framework |
| **Dart** | Programming language |
| **Material Design** | UI components and design system |
| **REST API** | Backend data fetching (AlAdhan API) |
| **SharedPreferences** | Local storage for theme persistence |
| **SVG** | Vector graphics for icons |

## Why Flutter?
1. **Cross-Platform**: Single codebase for Android and iOS
2. **Hot Reload**: Fast development and testing
3. **Rich UI**: Beautiful widgets and animations
4. **Performance**: Native performance with compiled code
5. **Large Community**: Extensive packages and support

---

# 3. PROJECT ARCHITECTURE

## Clean Architecture Pattern
The project follows a clean and modular architecture:

```
lib/
├── main.dart              # App entry point
├── constants/             # App-wide constants
├── models/                # Data models
├── providers/             # State management
├── screens/               # UI screens
├── services/              # API and data services
├── theme/                 # App theming
└── widgets/               # Reusable UI components
```

## Design Patterns Used
1. **Singleton Pattern** - Used in API services
2. **Provider Pattern** - For theme state management
3. **Factory Pattern** - For creating model instances from JSON
4. **MVC Pattern** - Separation of Models, Views, and Controllers

---

# 4. FEATURES & MODULES

## 🏠 Module 1: Home Screen
- Islamic greeting (Assalamu Alaikum)
- Dynamic date display (system date)
- Category navigation cards
- Dark/Light theme toggle via drawer

## 📖 Module 2: Quran Pak
- **Parah List**: All 30 Parahs (Juz)
- **Surah List**: All 114 Surahs
- Search functionality
- Lazy loading for performance
- Arabic text with English translation

## 🕌 Module 3: Asma Ul Husna (99 Names of Allah)
- All 99 beautiful names of Allah
- Arabic text with correct diacritics
- Transliteration in English
- English meaning
- Lazy loading (15 items per page)

## ☪️ Module 4: Names of Prophet Muhammad ﷺ
- 33 blessed names of Prophet Muhammad ﷺ
- Arabic text
- Transliteration
- English meaning
- Pagination support

## 📿 Module 5: Six Kalmas
- All 6 Islamic Kalmas:
  1. Kalma Tayyab
  2. Kalma Shahadat
  3. Kalma Tamjeed
  4. Kalma Tawheed
  5. Kalma Astaghfar
  6. Kalma Radde Kufr
- Arabic text with full diacritics
- Transliteration
- English meaning

## 🤲 Module 6: Masnoon Duas
- 22 authentic daily Duas with references
- Categories: Sleeping, Eating, Travel, etc.
- Arabic text
- Transliteration
- English meaning
- Hadith references (Bukhari, Muslim, etc.)
- Lazy loading (8 items per page)

## 🎨 Module 7: Theme Management
- Light mode and Dark mode
- Theme persistence using SharedPreferences
- Smooth theme transitions

---

# 5. DEPENDENCIES & PACKAGES

## Main Dependencies (pubspec.yaml)

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter` | SDK | Core Flutter framework |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |
| `flutter_svg` | ^2.2.3 | SVG image rendering |
| `http` | ^1.2.0 | HTTP client for API calls |
| `shared_preferences` | ^2.2.2 | Local storage for theme persistence |

## Dev Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_test` | SDK | Testing framework |
| `flutter_lints` | ^5.0.0 | Code quality and linting |
| `flutter_launcher_icons` | ^0.14.2 | App icon generation |

## Package Descriptions

### 1. flutter_svg (^2.2.3)
- Renders SVG (Scalable Vector Graphics) files
- Used for app icons and Islamic decorations
- Provides `SvgPicture.asset()` widget

### 2. http (^1.2.0)
- HTTP client for making API requests
- Used to fetch Quran data from AlAdhan API
- Supports GET, POST, PUT, DELETE methods

### 3. shared_preferences (^2.2.2)
- Persistent key-value storage
- Used to save user's theme preference
- Data persists even after app restart

---

# 6. FILE STRUCTURE

## Complete Project Structure

```
noor_ul_quran_2/
├── lib/
│   ├── main.dart                    # App entry point & theme setup
│   │
│   ├── constants/
│   │   ├── app_assets.dart          # Asset paths (images, SVGs)
│   │   ├── app_colors.dart          # Color constants
│   │   └── app_strings.dart         # String constants
│   │
│   ├── models/
│   │   ├── ayah_model.dart          # Quran verse model
│   │   ├── dua_model.dart           # Dua data model
│   │   ├── kalma_model.dart         # Kalma data model
│   │   ├── name_model.dart          # Allah/Muhammad names model
│   │   ├── parah_model.dart         # Parah (Juz) model
│   │   └── surah_model.dart         # Surah model
│   │
│   ├── providers/
│   │   └── theme_provider.dart      # Theme state management
│   │
│   ├── screens/
│   │   ├── splash_screen.dart       # App launch screen
│   │   ├── onboarding_screen.dart   # First-time user intro
│   │   ├── home_screen.dart         # Main dashboard
│   │   ├── quran_pak_screen.dart    # Quran Parah/Surah list
│   │   ├── parah_detail_screen.dart # Parah content display
│   │   ├── surah_detail_screen.dart # Surah content display
│   │   ├── asma_ul_husna_screen.dart # 99 Names of Allah
│   │   ├── muhammad_names_screen.dart # Names of Prophet ﷺ
│   │   ├── six_kalma_screen.dart    # Six Kalmas display
│   │   └── masnoon_dua_screen.dart  # Daily Duas display
│   │
│   ├── services/
│   │   ├── api_service.dart         # Quran API service
│   │   ├── names_api_service.dart   # Allah/Muhammad names API
│   │   ├── kalma_service.dart       # Six Kalmas data service
│   │   └── dua_service.dart         # Masnoon Duas service
│   │
│   ├── theme/
│   │   └── app_theme.dart           # Light & Dark theme definitions
│   │
│   └── widgets/
│       ├── app_drawer.dart          # Navigation drawer
│       ├── ayah_item.dart           # Quran verse widget
│       ├── dua_card.dart            # Dua display card
│       ├── kalma_card.dart          # Kalma display card
│       ├── name_card.dart           # Name display card
│       └── shimmer_loading.dart     # Loading skeleton
│
├── assets/
│   └── svg/                         # SVG and PNG assets
│
├── android/                         # Android platform code
├── ios/                             # iOS platform code
└── pubspec.yaml                     # Project configuration
```

---

# 7. SCREENS DESCRIPTION

## 7.1 Splash Screen (`splash_screen.dart`)
- **Purpose**: App launch screen with branding
- **Features**:
  - App logo display
  - Bismillah calligraphy
  - Animated transition to onboarding/home
  - 2-3 second display duration

## 7.2 Onboarding Screen (`onboarding_screen.dart`)
- **Purpose**: First-time user introduction
- **Features**:
  - 2 introduction pages
  - Page 1: Quran reading feature intro
  - Page 2: Masnoon Dua feature intro
  - Skip and Next buttons
  - Page indicators

## 7.3 Home Screen (`home_screen.dart`)
- **Purpose**: Main navigation hub
- **Features**:
  - Hero banner with greeting and date
  - 6 category cards:
    - Quran Pak
    - Six Kalmah
    - Masnoon Doin
    - Allah Name
    - Muhammad Name
    - Azan Screen
  - Side drawer for theme toggle
  - Dynamic system date display

## 7.4 Quran Pak Screen (`quran_pak_screen.dart`)
- **Purpose**: Browse Quran by Parah or Surah
- **Features**:
  - Tab bar: Parah List | Surah List
  - Search functionality
  - List with number badges
  - Arabic names with English translations
  - Navigation to detail screens

## 7.5 Parah Detail Screen (`parah_detail_screen.dart`)
- **Purpose**: Display Parah content
- **Features**:
  - All Ayahs in the Parah
  - Arabic text display
  - English translation
  - Verse numbers
  - Lazy loading

## 7.6 Surah Detail Screen (`surah_detail_screen.dart`)
- **Purpose**: Display Surah content
- **Features**:
  - Surah header with Bismillah
  - All Ayahs of the Surah
  - Arabic and English text
  - Verse-by-verse display

## 7.7 Asma Ul Husna Screen (`asma_ul_husna_screen.dart`)
- **Purpose**: Display 99 Names of Allah
- **Features**:
  - Paginated list (15 per page)
  - Arabic name in decorative style
  - Transliteration
  - English meaning
  - Scroll-triggered pagination

## 7.8 Muhammad Names Screen (`muhammad_names_screen.dart`)
- **Purpose**: Display names of Prophet ﷺ
- **Features**:
  - 33 blessed names
  - Same display format as Asma Ul Husna
  - Pagination support

## 7.9 Six Kalma Screen (`six_kalma_screen.dart`)
- **Purpose**: Display Six Kalmas
- **Features**:
  - All 6 Kalmas in order
  - Large Arabic text
  - Full transliteration
  - Complete English translation
  - Card-based UI

## 7.10 Masnoon Dua Screen (`masnoon_dua_screen.dart`)
- **Purpose**: Display daily Islamic prayers
- **Features**:
  - 22 authentic Duas
  - Categories (Before Sleep, After Eating, etc.)
  - Hadith references
  - Lazy loading (8 per page)

---

# 8. API INTEGRATION

## Primary API: AlAdhan API
- **Base URL**: `https://api.aladhan.com/v1`
- **Purpose**: Quran data and Islamic information

### API Endpoints Used

| Endpoint | Purpose |
|----------|---------|
| `/asmaAlHusna` | 99 Names of Allah |
| `/juzs` | List of all Parahs |
| `/surah` | List of all Surahs |
| `/surah/{number}` | Surah details with Ayahs |

### API Service Implementation

```dart
class ApiService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';
  
  Future<List<SurahModel>> getSurahs() async {
    final response = await http.get(Uri.parse('$baseUrl/surah'));
    if (response.statusCode == 200) {
      // Parse JSON response
    }
  }
}
```

### Error Handling
- Network errors caught with try-catch
- User-friendly error messages
- Retry functionality

---

# 9. STATE MANAGEMENT

## Theme State Management
The app uses **InheritedWidget** pattern with **SharedPreferences** for theme persistence.

### Implementation

```dart
// Theme Provider
class ThemeProviderInheritedWidget extends InheritedWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  
  // Provides theme state to entire widget tree
}
```

### How it Works
1. App loads → Check SharedPreferences for saved theme
2. User toggles theme → Update state and save to SharedPreferences
3. App restarts → Theme restored from SharedPreferences

---

# 10. KEY CONCEPTS USED

## 10.1 Widgets
- **StatelessWidget**: For static UI (cards, badges)
- **StatefulWidget**: For dynamic UI (screens with data)

## 10.2 Navigation
```dart
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => NewScreen()),
);
```

## 10.3 Lazy Loading / Pagination
```dart
_scrollController.addListener(() {
  if (_scrollController.position.pixels >= 
      _scrollController.position.maxScrollExtent - 200) {
    _loadMoreItems();
  }
});
```

## 10.4 HTTP Requests
```dart
final response = await http.get(Uri.parse(url));
if (response.statusCode == 200) {
  final data = json.decode(response.body);
}
```

## 10.5 JSON Parsing
```dart
factory Model.fromJson(Map<String, dynamic> json) {
  return Model(
    field1: json['field1'],
    field2: json['field2'],
  );
}
```

## 10.6 RTL Support (Arabic Text)
```dart
Text(
  arabicText,
  textDirection: TextDirection.rtl,
  style: TextStyle(fontFamily: 'Amiri'),
)
```

## 10.7 Dark/Light Theme
```dart
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryMaroon,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
);
```

---

# 11. HOW TO RUN

## Prerequisites
1. Flutter SDK installed (version 3.9.2+)
2. Android Studio or VS Code
3. Android/iOS emulator or physical device

## Steps to Run

```bash
# 1. Clone or navigate to project
cd noor_ul_quran_2

# 2. Get dependencies
flutter pub get

# 3. Run on connected device
flutter run

# 4. Build APK for release
flutter build apk --release
```

## Common Commands

| Command | Purpose |
|---------|---------|
| `flutter pub get` | Download dependencies |
| `flutter run` | Run app in debug mode |
| `flutter run --release` | Run in release mode |
| `flutter build apk` | Build Android APK |
| `flutter clean` | Clean build files |
| `flutter doctor` | Check Flutter setup |

---

# 12. VIVA PREPARATION Q&A

## Basic Questions

### Q1: What is Flutter?
**Answer**: Flutter is an open-source UI software development kit created by Google. It is used to develop cross-platform applications for Android, iOS, Linux, macOS, Windows, and web from a single codebase using Dart programming language.

### Q2: What is Dart?
**Answer**: Dart is an object-oriented, class-based programming language developed by Google. It is the primary language used for Flutter development. Key features include null safety, async/await for asynchronous programming, and just-in-time (JIT) and ahead-of-time (AOT) compilation.

### Q3: What is the difference between StatelessWidget and StatefulWidget?
**Answer**: 
- **StatelessWidget**: Does not maintain state. The UI doesn't change after creation. Example: Text, Icon.
- **StatefulWidget**: Maintains mutable state. UI can be updated using setState(). Example: Forms, interactive screens.

### Q4: What is the purpose of pubspec.yaml?
**Answer**: pubspec.yaml is the configuration file for Flutter projects. It contains:
- Project name and description
- SDK version constraints
- Dependencies (packages)
- Assets (images, fonts)
- Dev dependencies

### Q5: How does navigation work in Flutter?
**Answer**: Flutter uses a Navigator widget with a stack-based system:
```dart
// Push new screen
Navigator.push(context, MaterialPageRoute(builder: (context) => NewScreen()));

// Go back
Navigator.pop(context);
```

## Project-Specific Questions

### Q6: What APIs does your app use?
**Answer**: The app uses the AlAdhan API (api.aladhan.com) for:
- Fetching 99 Names of Allah
- Getting list of Surahs and Parahs
- Retrieving Quran verses

### Q7: How do you handle dark/light theme?
**Answer**: We use:
1. InheritedWidget to provide theme state to all widgets
2. SharedPreferences to persist user's theme choice
3. ThemeData to define light and dark color schemes

### Q8: What is lazy loading and why did you use it?
**Answer**: Lazy loading is loading data in chunks as needed instead of all at once. Benefits:
- Faster initial load time
- Less memory usage
- Better user experience
We load 8-15 items at a time and fetch more when user scrolls near the bottom.

### Q9: How do you display Arabic text correctly?
**Answer**: We use:
- `textDirection: TextDirection.rtl` for right-to-left text
- Arabic-compatible fonts (Amiri)
- Proper UTF-8 encoding

### Q10: What design pattern does your app follow?
**Answer**: The app follows:
- **Clean Architecture**: Separation into models, services, screens, widgets
- **Singleton Pattern**: For API services (one instance throughout app)
- **Factory Pattern**: For creating model objects from JSON

### Q11: How do you handle errors from API calls?
**Answer**: We use try-catch blocks:
```dart
try {
  final response = await http.get(url);
  // Process response
} catch (e) {
  // Show error message to user
  // Log error for debugging
}
```

### Q12: What is the benefit of using Flutter for this project?
**Answer**: 
1. Single codebase for both Android and iOS
2. Hot reload for fast development
3. Beautiful UI with Material Design
4. Large collection of packages
5. Good performance with native compilation

---

# 📊 PROJECT STATISTICS

| Metric | Value |
|--------|-------|
| Total Dart Files | 32 |
| Screens | 10 |
| Models | 6 |
| Services | 4 |
| Widgets | 6 |
| Packages Used | 4 |
| Assets | 11 |

---

# 🏆 CONCLUSION

Noor-Ul-Quran is a comprehensive Islamic mobile application that demonstrates proficiency in:

1. **Flutter Development**: Cross-platform mobile app development
2. **API Integration**: RESTful API consumption
3. **State Management**: Theme persistence and data handling
4. **UI/UX Design**: Islamic-themed, accessible interface
5. **Clean Code**: Modular architecture and best practices

The application provides Muslims with easy access to essential Islamic content including the Holy Quran, prayers, and fundamental teachings, all within a beautifully designed mobile interface.

---

**Submitted By**: [Your Name]  
**Roll Number**: [Your Roll Number]  
**Course**: Mobile Application Development  
**Semester**: 7th  
**Date**: January 2026

---

*بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ*
*In the name of Allah, the Most Gracious, the Most Merciful*
