import 'package:flutter/material.dart';
import 'package:inventoryapp/UI/theme/app_theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurfaceColor = theme.colorScheme.onSurface;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // Company name
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.category_rounded,
                        color: theme.colorScheme.primary,
                        size: 50,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        " App Inventario",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: onSurfaceColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                Image.asset(
                  'lib/UI/images/WelcomePageIMG.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                ),

                const SizedBox(height: 50),

                // Título
                Text(
                  'Bienvenido a "Nombre de prueba para aplicacion"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: theme.colorScheme.primary,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                // Subtexto
                Text(
                  "La mejor solución para llevar el inventario de tu empresa de una manera fácil y eficiente.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,

                    color: onSurfaceColor.withValues(alpha: 0.8),
                  ),
                ),

                const SizedBox(height: 50),

                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/login'),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Center(
                      child: Text(
                        "¡Empecemos!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Texto inferior
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Agiliza tu proceso de inventario hoy',
                style: TextStyle(
                  fontSize: 16,
                  color: onSurfaceColor.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
