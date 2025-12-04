import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../providers/favorites_provider.dart';
import '../models/weather.dart';

class WeatherDetailsPage extends StatefulWidget {
  const WeatherDetailsPage({super.key});

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  String? _city;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_city == null) {
      final args = ModalRoute.of(context)?.settings.arguments;
      _city = args is String ? args : null;

      if (_city != null) {
        final provider = context.read<WeatherProvider>();
        provider.fetchWeatherForCity(_city!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final Weather? weather = provider.weather;
    final bool isLoading = provider.isLoading;
    final String? error = provider.errorMessage;

    final favoritesProvider = context.watch<FavoritesProvider>();
    final bool isFav = weather != null &&
        favoritesProvider.isFavorite(weather.cityName);

    return Scaffold(
      appBar: AppBar(
        title: Text(_city ?? weather?.cityName ?? 'Weather Details'),
        actions: [
          if (weather != null)
            IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                if (isFav) {
                  favoritesProvider.removeFavorite(weather.cityName);
                } else {
                  favoritesProvider.addFavorite(weather.cityName);
                }
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Builder(
          builder: (_) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (error != null) {
              return Center(
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (weather == null) {
              return const Center(
                child: Text('No weather data'),
              );
            }

            final timeFormat = DateFormat.Hm(); // HH:mm

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    weather.cityName,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weather.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Image.network(
                    weather.iconUrl,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${weather.temperature.toStringAsFixed(1)}°',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Feels like ${weather.feelsLike.toStringAsFixed(1)}°',
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Local time: ${timeFormat.format(weather.localTime)}',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoTile(
                        label: 'Humidity',
                        value: '${weather.humidity}%',
                      ),
                      _InfoTile(
                        label: 'Wind',
                        value: '${weather.windSpeed} m/s',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoTile(
                        label: 'Sunrise',
                        value: timeFormat.format(weather.sunrise),
                      ),
                      _InfoTile(
                        label: 'Sunset',
                        value: timeFormat.format(weather.sunset),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
