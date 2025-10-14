import 'package:flutter/material.dart'; //importaciones, en el futuro se necesitarán más

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.category_rounded, color: Color(0xFF892BE2), size: 50),
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
        automaticallyImplyLeading: false,
      ),
      body: cuerpo(context),
    );
  }
}

Widget cuerpo(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          "https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/media/image/2021/04/anime-ataque-titanes-shingeki-no-kyojin-2289875.jpg?tf=3840x",
        ),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          tituloLogIn(),
          campoUsuario(),
          campoContrasena(),
          botonEntrar(context),
        ],
      ),
    ),
  );
}

Widget tituloLogIn() {
  return Text(
    "Acceder",
    style: TextStyle(
      color: Colors.black,
      fontSize: 35.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget campoUsuario() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Usuario",
        fillColor: Colors.white,
        filled: true,
      ),
    ),
  );
}

Widget campoContrasena() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Contraseña",
        fillColor: Colors.white,
        filled: true,
      ),
    ),
  );
}

Widget botonEntrar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
    child: TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/selection'); // acción correcta
      },
      child: const Text("Enviar", style: TextStyle(fontSize: 18)),
    ),
  );
}
