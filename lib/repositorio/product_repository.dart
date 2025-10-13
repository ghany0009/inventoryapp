import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/producto.dart';

class ProductRepository {
  final CollectionReference _col = FirebaseFirestore.instance.collection(
    'productos',
  );

  // ---------- CREATE ----------
  Future<String> createProduct(Producto product) async {
    final docRef = await _col.add(product.toMap());
    return docRef.id;
  }

  // ---------- READ (stream) ----------
  Stream<List<Producto>> getAllProducts() {
    return _col.snapshots().map(
      (snap) => snap.docs
          .map(
            (doc) => Producto.fromFirestore(
              doc.id,
              doc.data() as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  // ---------- READ single ----------
  Future<Producto?> getProductById(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists) return null;
    return Producto.fromFirestore(doc.id, doc.data() as Map<String, dynamic>);
  }

  // ---------- UPDATE ----------
  Future<void> updateProduct(Producto product) async {
    await _col.doc(product.id).update(product.toMap());
  }

  // ---------- DELETE ----------
  Future<void> deleteProduct(String id) async {
    await _col.doc(id).delete();
  }
}
