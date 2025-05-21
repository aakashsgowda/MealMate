# MealMate 🍽️

MealMate is a meal planning and recipe browsing app developed using Flutter. Built as a final project for **CS 442: Mobile Application Development** at Illinois Tech, it enables users to explore new recipes, organize weekly meal plans, and manage grocery lists.

---

## 🧑‍💻 Developer Info

- **Name**: Aakash Shivanandappa Gowda  
- **AID**: A20548984

---

## ✅ Self-Evaluation Checklist

| Feature                                                                                      | Completed |
|----------------------------------------------------------------------------------------------|-----------|
| App builds without error                                                                     | ✅         |
| Tested on: iOS Simulator / macOS                                                             | ✅         |
| Tested on: Android Emulator                                                                  | ✅         |
| At least 3 separate screens/pages in the app                                                 | ✅         |
| Contains at least one stateful widget backed by a custom model class using state management | ✅         |
| User-updateable data persists across app launches                                            | ✅         |
| Application uses and displays external data from a RESTful API                               | ✅         |
| Includes 5+ unit tests, 5+ widget tests, and 1 integration test group                        | ✅         |

---

## 📱 What Does the App Do?

MealMate helps users:

- Discover random meals
- Search meals by keyword
- View detailed meal information (ingredients and instructions)
- Add meals to a weekly meal planner
- Mark meals as favorites
- Generate a grocery list based on selected meals
- Persist all user selections across app launches

---

## 🌐 External Data Sources

- **TheMealDB API**  
  - Type: RESTful API  
  - Purpose: Fetch meal details including names, images, ingredients, and instructions.

---

## 📦 Dependencies

| Package             | Purpose                                               |
|---------------------|--------------------------------------------------------|
| `provider`          | App-wide state management                             |
| `http`              | Access TheMealDB API                                  |
| `shared_preferences`| Lightweight local data persistence                    |
| `flutter_test`      | Widget and unit testing                               |
| `integration_test`  | End-to-end UI and workflow testing                    |

---

## 💾 Local Data Persistence

Used `shared_preferences` to store:

- Favorite meals
- Weekly meal planner selections
- Grocery list items

This ensured users don’t lose their data between app launches.

---

## 🔍 Integration Test Workflow

The integration test covers:

1. App launch and meal loading
2. Viewing meal details
3. Adding a meal to the planner
4. Marking a meal as favorite
5. Verifying meal presence in Planner and Favorites tabs

This confirms that app state flows and persistence work end-to-end.

---

## 🚀 Getting Started

### Clone the Repo

```bash
git clone https://github.com/aakashsgowda/MealMate.git
cd MealMate
flutter pub get
flutter run
