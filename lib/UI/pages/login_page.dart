import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inventoryapp/providers/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.category_rounded),
            SizedBox(width: 8),
            Text(" App Inventario"),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                tituloLogIn(context),
                campoUsuario(_identifierController),
                campoContrasena(_passwordController),
                const SizedBox(height: 20),
                loginProvider.isLoading
                    ? const CircularProgressIndicator()
                    : campoEnviar(context, loginProvider, _identifierController, _passwordController),
                dirigirARegistro(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------- COMPONENTES --------------------

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

Widget campoUsuario(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: "Usuario o Email",
        labelText: "Usuario o Email",
        filled: true,
      ),
    ),
  );
}

Widget campoContrasena(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: controller,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: "Contraseña",
        labelText: "Contraseña",
        filled: true,
      ),
    ),
  );
}

Widget campoEnviar(
    BuildContext context,
    LoginProvider loginProvider,
    TextEditingController identifierController,
    TextEditingController passwordController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () async {
        final identifier = identifierController.text.trim();
        final password = passwordController.text.trim();

        if (identifier.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Por favor completa todos los campos'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        await loginProvider.loginUser(identifier: identifier, password: password);

        if (loginProvider.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loginProvider.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login realizado con exito'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, '/selection');
        }
      },
      child: const Text("Enviar", style: TextStyle(fontSize: 18)),
    ),
  );
}

Widget dirigirARegistro(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "No tienes cuenta?",
          style: TextStyle(fontSize: 18),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text("Registrate", style: TextStyle(fontSize: 15)),
        ),
      ],
    ),
  );
}

