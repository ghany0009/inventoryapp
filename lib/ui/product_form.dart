import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/producto.dart';
import '../providers/producto_provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _descripcionCtrl = TextEditingController();
  final TextEditingController _categoriaCtrl = TextEditingController();
  final TextEditingController _stockCtrl = TextEditingController();
  final TextEditingController _precioCtrl = TextEditingController();

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descripcionCtrl.dispose();
    _categoriaCtrl.dispose();
    _stockCtrl.dispose();
    _precioCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final producto = Producto(
      id: '',
      nombre: _nombreCtrl.text.trim(),
      descripcion: _descripcionCtrl.text.trim(),
      categoria: _categoriaCtrl.text.trim(),
      stock: int.tryParse(_stockCtrl.text.trim()) ?? 0,
      precio: double.tryParse(_precioCtrl.text.trim()) ?? 0.0,
    );

    final provider = Provider.of<ProductoProvider>(context, listen: false);
    await provider.addProducto(producto);

    if (!mounted) return;

    if (provider.error == null) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${provider.error}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductoProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Crear producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nombreCtrl,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                ),
                TextFormField(
                  controller: _descripcionCtrl,
                  decoration: const InputDecoration(labelText: 'Descripcion'),
                  maxLines: 2,
                ),
                TextFormField(
                  controller: _categoriaCtrl,
                  decoration: const InputDecoration(labelText: 'Categoria'),
                ),
                TextFormField(
                  controller: _stockCtrl,
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Requerido';
                    if (int.tryParse(v) == null) return 'Número inválido';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _precioCtrl,
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Requerido';
                    if (double.tryParse(v) == null) return 'Número inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                provider.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submit, child: const Text('Crear')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
