import 'package:flutter/material.dart';
import 'package:inventoryapp/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:inventoryapp/providers/theme_provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
// Importar paginas y temas
import 'package:inventoryapp/UI/screens.dart';

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
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: 'App Inventario',
              debugShowCheckedModeBanner: false,
              // Configuración del tema
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,

              // Rutas de tu aplicación
              initialRoute: '/',
              routes: {
                '/': (context) => const WelcomePage(),
                '/login': (context) => const LoginPage(),
                '/selection': (context) => const SelectionPage(),
                // ...otras rutas
              },
            );
          },
        ),
      ),
    );
  }
}
