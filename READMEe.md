# Flutter Weather App 🌤️

A multi-page Flutter application that displays **real-time current weather** data using the **OpenWeatherMap Current Weather API**.  
Users can:

- Search for any city
- View detailed weather information
- Save favorite cities
- Change temperature units between **Celsius (°C)** and **Fahrenheit (°F)**

---

## 📝 App Description

This app is a practice project for:

- **REST API integration** with OpenWeatherMap
- **Flutter UI development**
- **Navigation & routing**
- **State management** using `provider`
- **Local storage** using `shared_preferences`

The app communicates with the OpenWeatherMap **Current Weather Data API** to fetch live weather for a city and presents it in a clean, responsive UI.

---

## ✨ Features

### 1. Home / Search Screen
- Text field to **search weather by city name**
- Simple and clean layout
- Navigation to **Weather Details Screen** when a city is searched

### 2. Weather Details Screen
Displays live weather data fetched from the API, including:

- City name
- Current temperature
- Weather description
- “Feels like” temperature
- Humidity
- Wind speed
- Sunrise & Sunset times (formatted using timezone offset)
- Local time in the city (calculated with timezone offset)
- Weather icon loaded from OpenWeatherMap icon URL
- Button (icon) to **add/remove city from Favorites**

### 3. Favorites Screen
- Shows a **list of favorite cities** saved by the user
- Favorites are stored locally using **`shared_preferences`**
- Tapping a favorite city **opens its Weather Details Screen**
- Option to **remove** a city from favorites

### 4. Settings Screen
- Select **temperature unit**:
  - `Metric (°C)`
  - `Imperial (°F)`
- Selected unit is stored using `shared_preferences`
- New searches use the selected unit (°C or °F)

---

## 🧱 Architecture & Folder Structure

The project follows a simple, scalable folder structure:

```text
lib/
  main.dart
  config/
    api_config.dart           # API base URL + API key (local, not committed)
  models/
    weather.dart              # Weather model mapped from API response
  services/
    weather_api_service.dart  # Handles HTTP requests to OpenWeatherMap
  providers/
    weather_provider.dart     # Manages weather state and units (°C/°F)
    favorites_provider.dart   # Manages favorite cities and local storage
  pages/
    home_page.dart            # Search screen
    weather_details_page.dart # Weather details + add to favorites
    favorites_page.dart       # List of favorite cities
    settings_page.dart        # Temperature unit selection
  widgets/
    # (Optional) Custom reusable widgets if needed
