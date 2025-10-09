import 'package:flutter/material.dart';
import 'package:inventoryapp/UI/screens.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            //Company name
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.category_rounded,
                    color: Color(0xFF892BE2),
                    size: 50,
                  ),

                  Text(
                    " App Inventario", //Nombre de la compañia
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 41, 0, 112),
                    ),
                  ),
                ],
              ),
            ),

            //image
            Image.asset('lib/UI/images/WelcomePageIMG.png', width: 380),

            //separacion
            SizedBox(height: 80),

            //text
            const Text(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xFF892BE2),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),

              'Bienvenido a "Nombre de prueba para aplicacion" ',
            ),

            //subtext
            const Text(
              textAlign: TextAlign.center,
              "La mejor solucion para llevar el inventario de tu empresa de una manera facil y eficiente",
            ),

            //Separacion
            const SizedBox(height: 70),
            //button
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF892BE2),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(25),
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

            //espacio
            SizedBox(height: 170),
            //texto
            Text('Agiliza tu proceso de inventario hoy'),
          ],
        ),
      ),
    );
  }
}
