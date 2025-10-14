import 'package:flutter/material.dart';
import 'package:inventoryapp/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos la instancia del provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ajustes", style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Modo Oscuro'),
              trailing: Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  // Llamamos al método del provider para cambiar el tema
                  themeProvider.toggleTheme(value);
                },
              ),
            ),
            // Aquí puedes añadir más ajustes en el futuro
          ],
        ),
      ),
    );
  }
}
