import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'weather_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: provider.favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite cities',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (_, index) {
                final city = provider.favorites[index];
                return Card(
                  color: Colors.blue.shade50,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.location_city, color: Colors.blue),
                    title: Text(
                      city,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => provider.removeFavorite(city),
                    ),
                    onTap: () async {
                      await provider.fetchWeatherByCity(city);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const WeatherPage()),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}