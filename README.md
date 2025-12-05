# Weather App

## Project Overview
Weather App is a Flutter application that allows users to check the current weather for any city.  
The app provides:
- Search for a city and view its weather details.
- Add cities to Favorites for quick access.
- View Recent Searches to easily revisit searched cities.
- Change temperature unit between Celsius and Fahrenheit in Settings.

## Features
- *Home Page*: Search bar, Recent Searches, navigation to Favorites and Settings.
- *Weather Page*: Displays temperature, feels like, humidity, wind speed, sunrise & sunset with weather icon and a button to add to Favorites.
- *Favorites Page*: List of favorite cities with option to remove a city or navigate to its weather.
- *Settings Page*: Toggle between Celsius and Fahrenheit units.

## Technologies Used
- Flutter & Dart
- Provider (State Management)
- Shared Preferences (Persistent storage for Favorites and Recent Searches)
- OpenWeatherMap API (Weather data)
- intl package (Time formatting)

## How to Run the Project
1. Open the project in VS Code or Android Studio.
2. Run the following commands in terminal:
```bash
flutter pub get
flutter run