// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

//     Nuestro provider que gestiona los productos
import 'providers/product_provider.dart';

//     Pantallas de la app
import 'UI/screens.dart'; // pantalla de login (ya la tienes)
//import 'presentation/pages/product_list_page.dart'; // pantalla principal tras login

void main() async {
  // -------------------------------------------------
  // Aseguramos que los plugins de Flutter estén listos
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializamos Firebase con la configuración adecuada para la plataforma
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Finalmente lanzamos la aplicación
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //     Registramos todos los providers que vamos a usar.
    //     En este caso solo necesitamos ProductProvider,
    //     pero puedes añadir más (AuthProvider, SettingsProvider,…)
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
        // Ejemplo de cómo añadir otro provider:
        // ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
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
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
