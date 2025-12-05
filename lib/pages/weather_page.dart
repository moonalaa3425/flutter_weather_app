import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/weather_provider.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool isCelsius = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final weather = provider.weather;

    if (provider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(provider.errorMessage!)),
      );
    }

    if (weather == null) {
      return const Scaffold(
        body: Center(child: Text('No weather data available')),
      );
    }

    final displayTemp =
        isCelsius ? weather.temperature : (weather.temperature * 9 / 5 + 32);
    final displayFeelsLike =
        isCelsius ? weather.feelsLike : (weather.feelsLike * 9 / 5 + 32);

    final sunrise = DateTime.fromMillisecondsSinceEpoch(
      weather.sunrise * 1000,
      isUtc: true,
    ).add(Duration(seconds: weather.timezoneOffset ?? 0));

    final sunset = DateTime.fromMillisecondsSinceEpoch(
      weather.sunset * 1000,
      isUtc: true,
    ).add(Duration(seconds: weather.timezoneOffset ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: Text(weather.cityName),
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: Icon(isCelsius ? Icons.thermostat : Icons.thermostat_outlined),
            tooltip: 'Change Unit',
            onPressed: () {
              setState(() {
                isCelsius = !isCelsius;
                provider.changeUnit(isCelsius ? 'metric' : 'imperial');
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Add to Favorites',
            onPressed: () => provider.addFavorite(weather.cityName),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              color: Colors.blue.shade50,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (weather.icon.isNotEmpty)
                          Image.network(
                            "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
                            width: 80,
                            height: 80,
                          ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            Text(
                              weather.description,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                                "Temperature: ${displayTemp.toStringAsFixed(1)}°${isCelsius ? 'C' : 'F'}",
                                style: const TextStyle(fontSize: 18)),
                            Text(
                                "Feels Like: ${displayFeelsLike.toStringAsFixed(1)}°${isCelsius ? 'C' : 'F'}"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.water_drop, color: Colors.blue, size: 30),
                            const SizedBox(height: 4),
                            Text("${weather.humidity}%", style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.air, color: Colors.green, size: 30),
                            const SizedBox(height: 4),
                            Text("${weather.windSpeed} m/s", style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.wb_sunny, color: Colors.orange, size: 30),
                            const SizedBox(height: 4),
                            Text("Sunrise: ${DateFormat.Hm().format(sunrise)}"),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.nights_stay, color: Colors.purple, size: 30),
                            const SizedBox(height: 4),
                            Text("Sunset: ${DateFormat.Hm().format(sunset)}"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}