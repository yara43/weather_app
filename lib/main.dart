import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/weather_details_page.dart';
import 'pages/favorites_page.dart';
import 'pages/settings_page.dart';
import 'providers/weather_provider.dart';
import 'providers/favorites_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/details': (context) => const WeatherDetailsPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
