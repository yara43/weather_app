import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final favorites = favoritesProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Cities'),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite cities yet.\nAdd some from the weather page ❤️',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final city = favorites[index];
                return ListTile(
                  title: Text(city),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        favoritesProvider.removeFavorite(city),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: city,
                    );
                  },
                );
              },
            ),
    );
  }
}
