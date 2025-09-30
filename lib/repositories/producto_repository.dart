import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/producto.dart';

class ProductoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProducto(Producto producto) async {
    await _firestore.collection('productos').add(producto.toMap());
  }

  Future<void> updateProducto(Producto producto) async {
    await _firestore
        .collection('productos')
        .doc(producto.id)
        .update(producto.toMap());
  }

  Future<void> deleteProducto(String id) async {
    await _firestore.collection('productos').doc(id).delete();
  }

  /* Stream<List<Producto>> getProductos() {
    return _firestore.collection('productos').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Producto.fromMap(doc.id, doc.data()))
          .toList();
    });*/
  Stream<List<Producto>> getProductos() {
    return _firestore
        .collection('productos')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Producto.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }
}
