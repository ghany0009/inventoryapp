import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movimiento.dart';

class HistoryRepository {
  final CollectionReference _col = FirebaseFirestore.instance.collection(
    'historial',
  );

  // CREATE: Añade un nuevo movimiento al historial
  Future<void> addMovement(Movimiento movimiento) async {
    await _col.add(movimiento.toMap());
  }

  // READ (Stream): Obtiene todos los movimientos en tiempo real, ordenados por fecha
  Stream<List<Movimiento>> getAllMovements() {
    return _col.orderBy('fecha', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Movimiento.fromFirestore(doc)).toList();
    });
  }
}
