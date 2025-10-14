import 'package:flutter/material.dart';
import 'package:inventoryapp/UI/pages/history_page.dart';
import 'package:inventoryapp/UI/pages/products_page.dart';
import 'package:inventoryapp/UI/pages/settings_page.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  int _selectedIndex = 0;

  // Páginas de ejemplo
  final List<Widget> _pages = [
    const ProductsPage(),
    const HistoryPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.category_rounded, color: Color(0xFF892BE2), size: 50),
            const SizedBox(width: 8),
            const Text(
              " App Inventario",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 41, 0, 112),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: _pages[_selectedIndex], // Muestra la página seleccionada
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inventario'),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later_outlined),
            label: 'Historial',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }
}
