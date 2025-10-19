import 'package:flutter/material.dart';
import 'package:inventoryapp/models/producto.dart';
import 'package:provider/provider.dart';
import 'package:inventoryapp/providers/product_provider.dart';


class EditProductPage extends StatefulWidget {
  final Producto? product; // null → modo crear

  const EditProductPage({Key? key, this.product}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String _nombre;
  late int _stock;
  late double _precio;

  @override
  void initState() {
    super.initState();
    _nombre = widget.product?.nombre ?? '';
    _stock = widget.product?.stock ?? 0;
    _precio = widget.product?.precio ?? 0.0;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final newProduct = Producto(
      //se omite la id para que Firestore la genere automáticamente
      nombre: _nombre,
      stock: _stock,
      precio: _precio,
      modelos:[], // Lista vacía por defecto, hay que modificar para guardar modelos 
    );

    final provider = context.read<ProductProvider>();
    if (widget.product == null) {
      await provider.addProduct(newProduct);
    } else {
      await provider.updateProduct(newProduct);
    }

    Navigator.of(context).pop(); // volver a la lista
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar producto' : 'Nuevo producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // NOMBRE
              TextFormField(
                initialValue: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Campo obligatorio' : null,
                onSaved: (v) => _nombre = v!.trim(),
              ),
              const SizedBox(height: 12),

              // STOCK
              TextFormField(
                initialValue: _stock.toString(),
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    int.tryParse(v ?? '') == null ? 'Entero válido' : null,
                onSaved: (v) => _stock = int.parse(v!),
              ),
              const SizedBox(height: 12),

              // PRECIO
              TextFormField(
                initialValue: _precio.toStringAsFixed(2),
                decoration: const InputDecoration(labelText: 'Precio (€)'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (v) =>
                    double.tryParse(v ?? '') == null ? 'Número válido' : null,
                onSaved: (v) => _precio = double.parse(v!),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: Text(isEdit ? 'Actualizar' : 'Crear'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}