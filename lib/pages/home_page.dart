import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final city = _cityController.text.trim();
    if (city.isEmpty) return;

    Navigator.pushNamed(
      context,
      '/details',
      arguments: city,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onSubmitted: (_) => _onSearch(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onSearch,
                child: const Text('Search'),
              ),
            ),
            const SizedBox(height: 32),
            const Expanded(
              child: Center(
                child: Text(
                  'Search for a city to see its weather 🌤️',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
