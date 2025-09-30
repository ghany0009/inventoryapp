import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'core/firebase_options.dart';
import 'providers/producto_provider.dart';
import 'ui/inventario_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductoProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestión de Inventario',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const InventarioPage(),
      ),
    );
  }
}
