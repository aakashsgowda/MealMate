# MP Report

## Team

- Name: Aakash Shivanandappa Gowda
- AID: A20548984

## Self-Evaluation Checklist

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:

- [X] The app builds without error
- [X] I tested the app in at least one of the following platforms (check all
      that apply):
  - [X] iOS simulator / MacOS
  - [X] Android emulator
- [X] There are at least 3 separate screens/pages in the app
- [X] There is at least one stateful widget in the app, backed by a custom model
      class using a form of state management
- [X] Some user-updateable data is persisted across application launches
- [X] Some application data is accessed from an external source and displayed in
      the app
- [X] There are at least 5 distinct unit tests, 5 widget tests, and 1
      integration test group included in the project

## Questionnaire

Answer the following questions, briefly, so that we can better evaluate your
work on this machine problem.

1. What does your app do?

   **MealMate** is a meal planning and recipe browsing app I developed. It lets users:
- Discover random meals
- Search for meals by keyword
- View detailed meal information (ingredients and instructions)
- Add meals to a weekly planner
- Mark meals as favorites
- Generate a grocery list based on selected meals
- Persist all user selections across app launches

2. What external data source(s) did you use? What form do they take (e.g.,
   RESTful API, cloud-based database, etc.)?

   I used [TheMealDB](https://www.themealdb.com/), which is a **RESTful API** providing structured data about meals. It offers dynamic content including meal names, thumbnails, ingredients, and preparation instructions.

3. What additional third-party packages or libraries did you use, if any? Why?

   I used the following packages:
- `provider`: to manage and share state efficiently across the app
- `http`: to make API requests to TheMealDB
- `shared_preferences`: to persist planner, favorites, and groceries
- `flutter_test`, `integration_test`: to write unit, widget, and integration tests

   These packages helped me structure my app efficiently and meet all the requirements.

4. What form of local data persistence did you use?

   I used `shared_preferences` to persist data such as:
- Favorite meals
- Weekly meal planner selections
- Grocery items list

   This method provided a lightweight and effective way to store data locally without setting up a full database.

5. What workflow is tested by your integration test?

   The integration test walks through the following flow:
   1. Launch the app and wait for random meals to load
   2. Tap on a meal card to view its details
   3. Add the meal to the planner
   4. Mark the meal as a favorite
   5. Navigate to the Favorites and Planner tabs to verify the meal is displayed correctly

   This tests the core functionality I implemented: browsing, planning, and saving meals.
---
## Summary and Reflection

   Working on MealMate was a rewarding experience. I designed the app to integrate state management with Provider, data fetching via a RESTful API, and local persistence using `shared_preferences`. I structured the UI with four main pages: Home, Planner, Favorites, and Groceries.

   All required features were implemented:
- At least 3 pages (I created 4)
- A stateful widget backed by a Provider-based model
- Local persistence with `shared_preferences`
- External data access using a RESTful API
- Full test suite with unit, widget, and integration tests

   I enjoyed building a practical and visually appealing app with dynamic content. One challenge was writing integration tests involving async network calls and UI state. If I had more time, I’d explore animated transitions and deeper filtering options in meal search.

