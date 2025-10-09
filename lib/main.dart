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
      title: 'App Inventario',
      home: WelcomePage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/products': (context) => const ProductsPage(),
        '/settings': (context) => const SettingsPage(),
        '/welcome': (context) => const WelcomePage(),
        '/history': (context) => const HistoryPage(),
      },
    );
  }
}
