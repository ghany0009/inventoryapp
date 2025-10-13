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
      appBar: AppBar(title: Text("Mi aplicacion")),
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
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text("Enviar", style: TextStyle(fontSize: 18)),
    ),
  );
}
