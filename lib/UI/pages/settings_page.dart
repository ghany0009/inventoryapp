import 'package:flutter/material.dart';
import 'package:inventoryapp/providers/theme_provider.dart';
import 'package:inventoryapp/providers/register_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _goToAccountInfo(BuildContext context) {

  }

    void _logout(BuildContext context) async {
    final registerProvider = Provider.of<RegisterProvider>(context, listen: false);
    await registerProvider.logout();

    // Redirigir a la página de login y eliminar historial
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

    // Opcional: mostrar SnackBar confirmando cierre de sesión
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sesión cerrada correctamente'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.read<ThemeProvider>();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeMode = context.watch<ThemeProvider>().themeMode;
    final headlineStyle = Theme.of(context).textTheme.headlineSmall;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Cuenta",
                style: headlineStyle?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Información de la Cuenta'),
              onTap: () => _goToAccountInfo(context),
            ),

            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red[400]),
              title: Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red[400]),
              ),
              onTap: () => _logout(context), // <--- Funcionalidad
            ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Apariencia",
                style: headlineStyle?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              title: const Text('Modo Oscuro'),
              trailing: Switch(
                value: isDark && themeMode != ThemeMode.light,
                onChanged: (value) {
                  themeNotifier.toggleTheme(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
