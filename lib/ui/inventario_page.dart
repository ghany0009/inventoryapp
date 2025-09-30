import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/producto_provider.dart';
import 'product_form.dart';

class InventarioPage extends StatelessWidget {
  const InventarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductoProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Inventario")),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.productos.length,
              itemBuilder: (context, index) {
                final producto = provider.productos[index];
                return Card(
                  child: ListTile(
                    title: Text(producto.nombre),
                    subtitle: Text(
                      "Stock: ${producto.stock}, Precio: ${producto.precio}€",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => provider.deleteProducto(producto.id),
                    ),
                  ),
                );
              },
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProductFormPage()),
            );
          },
          child: const Icon(Icons.add),
        ),
    );
  }
}
