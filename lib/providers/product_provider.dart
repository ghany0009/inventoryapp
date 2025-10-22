import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../repositorio/product_repository.dart';
import '../models/movimiento.dart'; // <-- AÑADE IMPORTACIÓN
import '../repositorio/history_repository.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository _repo = ProductRepository();
  final HistoryRepository _historyRepo = HistoryRepository();

  // Estado
  List<Producto> _products = [];
  List<Producto> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  // ---------- CARGAR LISTADO ----------
  Future<void> loadAll() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Usamos un stream para que la UI se actualice automáticamente
      _repo.getAllProducts().listen((list) {
        _products = list;
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      _error = 'Error al cargar productos: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // ---------- CREAR ----------
  Future<void> addProduct(Producto product) async {
    _isLoading = true;
    notifyListeners();
    try {
      final id = await _repo.createProduct(product);
      // El producto recien creado tiene id vacio;
      //le asignamos el id que devuelve firestore
      _products.add(product.copyWith(id: id));
    } catch (e) {
      _error = 'Error al crear producto: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ---------- ACTUALIZAR ----------
  Future<void> updateProduct(Producto product) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.updateProduct(product);
      final idx = _products.indexWhere((p) => p.id == product.id);
      if (idx >= 0) _products[idx] = product;
    } catch (e) {
      _error = 'Error al actualizar: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ---------- ELIMINAR ----------
  Future<void> deleteProduct(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.deleteProduct(id);
      _products.removeWhere((p) => p.id == id);
    } catch (e) {
      _error = 'Error al eliminar: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- LÓGICA DE STOCK E HISTORIAL ---
  Future<void> updateStock({
    required Producto producto,
    required int cantidad,
    required TipoMovimiento tipo,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // 1. Calcular el nuevo stock
      final nuevoStock = (tipo == TipoMovimiento.entrada)
          ? producto.stock + cantidad
          : producto.stock - cantidad;

      if (nuevoStock < 0) {
        throw Exception("El stock no puede ser negativo.");
      }

      // 2. Crear el objeto de movimiento para el historial
      final movimiento = Movimiento(
        id: '', // Firestore lo genera automáticamente
        productoId: producto.id!, //añadida la ! porque id no puede ser nulo aqui
        productoNombre: producto.nombre,
        tipo: tipo,
        cantidad: cantidad,
        fecha: DateTime.now(),
      );

      // 3. Actualizar el producto con el nuevo stock
      await _repo.updateProduct(producto.copyWith(stock: nuevoStock));

      // 4. Añadir el registro al historial
      await _historyRepo.addMovement(movimiento);
    } catch (e) {
      _error = 'Error al actualizar stock: $e';
    } finally {
      _isLoading = false;
      notifyListeners(); // La UI se actualizará por el stream, pero notificamos por si acaso
    }
  }
}
