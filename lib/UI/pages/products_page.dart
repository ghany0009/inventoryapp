import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/providers/product_provider.dart';
import 'package:inventoryapp/models/producto.dart';
import 'package:provider/provider.dart';
import 'package:inventoryapp/UI/pages/edit_products_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Producto? _selected; // Variable para rastrear el producto seleccionado
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
                      color: Theme.of(context).colorScheme.surfaceVariant,
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
                  backgroundColor: Colors.red,
                  onPressed: _selected == null //<= nombre de la variable de selección                  _selected == null //<= nombre de la variable de selección
                  ? null      //boton gris si no responde
                  : () async {
                                     
                   //obtener la instancia del provider
                   final productProvider = context.read<ProductProvider>();

                   await productProvider.deleteProduct(_selected!.id!);
                   //Borra el doc en Firestore via provider
                   
                   setState(() => _selected = null);
                    // Limpiar selección visual después de eliminar
                    
                  },
                  child: const Icon(Icons.delete),
                  
                ),
                const SizedBox(width: 10),

                // Botón Editar
                FloatingActionButton(
                  heroTag: 'editar_fab',
                   backgroundColor: Colors.orange,
                  onPressed:
                  _selected == null
                   ? null     //deshabilita el boton (lo pone gris)cuando el usuario no selecciona producto
                    : () async{
                      // Navegar a la pantalla de edición con el producto seleccionado
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProductPage(product: _selected!),
                        ),
                      );
                      // Al volver, limpiamos la selección
                      setState(() => _selected = null); 
                    
                  },
                  child: const Icon(Icons.edit),
                 
                ),
                const SizedBox(width: 10),

                // Botón Crear
                FloatingActionButton(
                  heroTag: 'crear_fab',
                  onPressed: () async {
                    print('Crear presionado');
                    //navegamos a la pantalla de creación
                     await Navigator.push(
                        context,
                          MaterialPageRoute(
                            builder: (_) => const EditProductPage(),  // <== Pantalla de creación
                          ),
                        );
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
