# MealMate 🍽️
A Flutter mobile application developed as part of CS 442: Mobile Application Development at Illinois Tech. This app helps users plan meals, browse recipes via an external API, and save favorites locally — with state management, persistence, and clean navigation.

## ✨ Features
- 🔁 **Multi-page Navigation**: Seamless routing between Home, Recipes, and Favorites pages
- 🧠 **State Management**: Custom model with `ChangeNotifier` for reactive updates
- 💾 **Local Persistence**: Store favorite meals using `SharedPreferences`
- 🌐 **External API Integration**: Fetches meal data from a RESTful API
- ✅ **Testing**: Includes unit, widget, and integration tests

## 📱 Screens
- **Home Page**: Intro and navigation entry point
- **Recipes Page**: Browse meals fetched from an API
- **Favorites Page**: User's saved favorite recipes (persisted across sessions)

## 🛠️ Tech Stack
- Flutter & Dart
- `http` for API access
- `provider` for state management
- `shared_preferences` for local data
- `flutter_test` for widget/unit tests

## 📦 Installation

```bash
git clone https://github.com/aakashsgowda/MealMate.git
cd MealMate
flutter pub get
flutter run
