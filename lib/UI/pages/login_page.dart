import 'package:flutter/material.dart';

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
            Icon(Icons.category_rounded),
            const SizedBox(width: 8),
            const Text(" App Inventario", style: TextStyle()),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: cuerpo(context),
    );
  }
}

Widget cuerpo(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        tituloLogIn(context),
        campoUsuario(),
        campoContrasena(),
        botonEntrar(context),
      ],
    ),
  );
}

Widget tituloLogIn(BuildContext context) {
  return Text(
    "Acceder",
    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    ),
  );
}

Widget campoUsuario() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      decoration: InputDecoration(hintText: "Usuario", filled: true),
    ),
  );
}

Widget campoContrasena() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(hintText: "Contraseña", filled: true),
    ),
  );
}

Widget botonEntrar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
    child: TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/selection');
      },
      child: const Text("Enviar", style: TextStyle(fontSize: 18)),
    ),
  );
}
