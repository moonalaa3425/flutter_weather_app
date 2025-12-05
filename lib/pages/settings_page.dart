import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Temperature Unit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              color: Colors.blue.shade50,
              elevation: 3,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  RadioListTile<String>(
                    value: 'metric',
                    groupValue: provider.unit,
                    title: const Text('Celsius (°C)'),
                    secondary: const Icon(Icons.thermostat, color: Colors.orange),
                    onChanged: (value) {
                      if (value != null) provider.changeUnit(value);
                    },
                  ),
                  RadioListTile<String>(
                    value: 'imperial',
                    groupValue: provider.unit,
                    title: const Text('Fahrenheit (°F)'),
                    secondary: const Icon(Icons.thermostat_outlined, color: Colors.red),
                    onChanged: (value) {
                      if (value != null) provider.changeUnit(value);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}