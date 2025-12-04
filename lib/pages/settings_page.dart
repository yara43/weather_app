import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    final currentUnits = weatherProvider.units;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Temperature Unit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RadioListTile<String>(
            title: const Text('Celsius (°C)'),
            value: 'metric',
            groupValue: currentUnits,
            onChanged: (value) {
              if (value != null) {
                weatherProvider.setUnits(value);
              }
            },
          ),
          RadioListTile<String>(
            title: const Text('Fahrenheit (°F)'),
            value: 'imperial',
            groupValue: currentUnits,
            onChanged: (value) {
              if (value != null) {
                weatherProvider.setUnits(value);
              }
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'New searches will use the selected unit.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
