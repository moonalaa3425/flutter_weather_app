# 🌤️ Flutter Weather App

A multi-page Flutter application that displays real-time weather data using the **OpenWeatherMap Current Weather API**.  
The app allows users to search for cities, view detailed weather information, save favorites, and customize temperature units.

---

## 📌 Features

### 🏠 Home / Search Screen
- Search for any city by name  
- View **recent searches**  
- Quick navigation to **Favorites** and **Settings**  

### 🌦️ Weather Details Screen
Displays real-time weather information:
- City name  
- Temperature  
- Weather description  
- Feels like  
- Humidity  
- Wind speed  
- Sunrise & Sunset (converted using timezone offset)  
- Weather icon from OpenWeatherMap  
- Local time  
- Add city to Favorites  

### ⭐ Favorites Screen
- Shows list of saved favorite cities  
- Navigate to a city’s weather  
- Remove a city from favorites  

### ⚙️ Settings Screen
- Switch temperature unit:
  - Celsius (°C)
  - Fahrenheit (°F)
- (More settings can be added)  

---

## 🛠️ Technologies Used
- **Flutter & Dart**
- **Provider** (state management)
- **Shared Preferences** (local storage)
- **OpenWeatherMap API**
- **HTTP package**
- **intl package** (time formatting)

---

## 🔧 Project Architecture
lib/
├── models/
├── pages/
├── services/
├── widgets/
├── providers/
└── main.dart

---

## 🔑 API Key Setup (Important)
1. Create the file:  
lib/config/api_keys.dart
2. Add this inside it:
```dart
const String openWeatherApiKey = "YOUR_API_KEY_HERE";
Do NOT upload your real API key to GitHub.

Add the file to .gitignore:
lib/config/api_keys.dart

🚀 How to Run the Project
1️⃣ Install Dependencies
flutter pub get
2️⃣ Run the App
flutter run
3️⃣ Build APK (for submission)
flutter build apk --release
APK will be located at:
build/app/outputs/flutter-apk/app-release.apk
