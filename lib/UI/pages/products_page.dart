import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      // 1. Usamos un Stack para superponer los botones sobre la lista.
      body: Stack(
        children: [
          // Capa inferior: Tu lista de productos existente
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("productos")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    'Sin productos',
                    style: TextStyle(color: onSurface),
                  ),
                );
              }

              final productos = snapshot.data!.docs;

              // Hacemos que la lista tenga un poco de espacio en la parte inferior
              // para que el último elemento no quede oculto por los botones.
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  80,
                ), // Aumentamos el padding inferior
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final doc = productos[index];
                  final nombre = doc['nombre'] ?? '';
                  final stock = doc['stock'] ?? 0;
                  final precio = doc['precio'] ?? 0;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            nombre,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: onSurface,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "$stock ${stock == 1 ? 'unidad' : 'unidades'}",
                              style: TextStyle(
                                fontSize: 16,
                                color: onSurface.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              "${precio.toStringAsFixed(2).replaceAll('.', ',')} €/ud.",
                              style: TextStyle(fontSize: 16, color: onSurface),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          // 2. Capa superior: Los botones fijos en la parte inferior.
          Positioned(
            bottom: 16,
            right: 16,
            child: Row(
              children: [
                // Botón Eliminar
                FloatingActionButton(
                  heroTag: 'eliminar_fab', // Tag único para cada FAB
                  onPressed: () {

                    // Lógica para eliminar (requiere seleccionar un producto)
                  },
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                const SizedBox(width: 10),

                // Botón Editar
                FloatingActionButton(
                  heroTag: 'editar_fab',
                  onPressed: () {

                    // Lógica para editar (requiere seleccionar un producto)
                  },
                  backgroundColor: Colors.orange,
                  child: const Icon(Icons.edit),
                ),
                const SizedBox(width: 10),

                // Botón Crear
                FloatingActionButton(
                  heroTag: 'crear_fab',
                  onPressed: () {
                  },
                  backgroundColor: primary,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
