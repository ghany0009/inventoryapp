import 'package:flutter/material.dart';
import 'package:inventoryapp/providers/register_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 🔹 Controladores para leer los valores de los campos
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.category_rounded),
            const SizedBox(width: 8),
            const Text(" Registrarse"),
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
              children: <Widget>[
                tituloRegistrar(context),
                campoUsuario(_usuarioController),
                campoEmail(_emailController),
                campoContrasena(_passwordController),
                const SizedBox(height: 20),
                // 🔹 Botón para registrar
                registerProvider.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          // Validar que todos los campos estén completos
                          final username = _usuarioController.text.trim();
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();

                          if (username.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Por favor completa todos los campos'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // Ejecutar el registro
                          await registerProvider.registerUser(
                            username: username,
                            email: email,
                            password: password,
                          );

                          if (registerProvider.errorMessage != null) {
                            // Mostrar error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text(registerProvider.errorMessage!),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            // Registro exitoso
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Usuario registrado correctamente'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        },
                        child: const Text(
                          "Registrarse",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                botonEntrar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------- COMPONENTES --------------------

Widget tituloRegistrar(BuildContext context) {
  return Text(
    "Registrarse",
    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
  );
}

Widget campoEmail(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: TextField(
      controller: controller,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: "example@example.com",
        labelText: "Email",
        filled: true,
      ),
    ),
  );
}

Widget campoUsuario(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: TextField(
      controller: controller,
      obscureText: false,
      decoration: const InputDecoration(
        hintText: "Escriba su usuario",
        labelText: "Usuario",
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
        hintText: "*******",
        labelText: "Contraseña",
        filled: true,
      ),
    ),
  );
}

Widget botonEntrar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "¿Ya tienes cuenta?",
          style: TextStyle(fontSize: 18),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text(
            "Inicia sesión",
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    ),
  );
}
