import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
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
                          color: Color(0xFF892BE2),
                          size: 50,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          " App Inventario",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 41, 0, 112),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Imagen principal
                  Image.asset(
                    'lib/UI/images/WelcomePageIMG.png',
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),

                  const SizedBox(height: 50),

                  // Título
                  const Text(
                    'Bienvenido a "Nombre de prueba para aplicacion"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xFF892BE2),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Subtexto
                  const Text(
                    "La mejor solución para llevar el inventario de tu empresa de una manera fácil y eficiente.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),

                  const SizedBox(height: 50),

                  // Boton
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/login'),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF892BE2),
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

              //Texto
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Agiliza tu proceso de inventario hoy',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
