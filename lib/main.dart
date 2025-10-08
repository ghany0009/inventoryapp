import 'package:flutter/material.dart';
import 'UI/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi App',
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/profile': (context) => const LoginPage(),
        '/products': (context) => const ProductsPage(),
        '/config': (context) => const SettingsPage(),
        '/welcome': (context) => const WelcomePage(),
      },
    );
  }
}
