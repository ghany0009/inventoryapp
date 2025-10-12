// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

//     Nuestro provider que gestiona los productos
import 'providers/product_provider.dart';

//     Pantallas de la app
import 'login_page.dart';                     // pantalla de login (ya la tienes)
//import 'presentation/pages/product_list_page.dart'; // pantalla principal tras login

void main() async {
  // -------------------------------------------------
  // Aseguramos que los plugins de Flutter estén listos
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializamos Firebase con la configuración adecuada para la plataforma
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Finalmente lanzamos la aplicación
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
        title: 'Inventario App',

        
        //     Ruta inicial → pantalla de login.
        //     Después de que el login sea exitoso, navegas a
        //     ProductListPage (lista de productos) usando
        //     Navigator.pushReplacement o un named route.
        home: const LoginPage(),

        
        //     Opcional: definir rutas nombradas para que
        //     la navegación sea más clara.
        routes: {
          // '/home' → pantalla principal con la lista de productos
          // '/home': (_) => const ProductListPage(),
          // Puedes añadir más rutas (detalle, formulario, etc.)
          // '/detail': (_) => const ProductDetailPage(),
          // '/form'  : (_) => const ProductFormPage(),
        },

        // -------------------------------------------------
        // 7️⃣  Tema (personaliza a tu gusto)
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}