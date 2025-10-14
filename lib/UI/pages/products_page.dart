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
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("productos").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Sin productos', style: TextStyle(color: onSurface)),
            );
          }

          final productos = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
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
                  color: onSurface.withValues(alpha: 0.1),
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
                      children: [
                        Text(
                          "$stock ${stock == 1 ? 'unidad' : 'unidades'}",
                          style: TextStyle(
                            fontSize: 16,

                            color: onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                        Text(
                          " ${precio.toStringAsFixed(2).replaceAll('.', ',')} €/ud.",
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
    );
  }
}
