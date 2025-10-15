// lib/models/movimiento.dart

import 'package:cloud_firestore/cloud_firestore.dart';

// Usar un enum hace tu código más seguro y legible que usar strings.
enum TipoMovimiento { entrada, salida }

class Movimiento {
  final String id; // ID del documento en Firestore
  final String productoId;
  final String
  productoNombre; // Denormalizamos para no tener que buscarlo después
  final TipoMovimiento tipo;
  final int cantidad;
  final DateTime fecha;

  Movimiento({
    required this.id,
    required this.productoId,
    required this.productoNombre,
    required this.tipo,
    required this.cantidad,
    required this.fecha,
  });

  // Factory para crear una instancia desde un documento de Firestore
  factory Movimiento.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Movimiento(
      id: doc.id,
      productoId: data['productoId'],
      productoNombre: data['productoNombre'],
      // Convierte el string de Firestore de nuevo a un enum
      tipo: TipoMovimiento.values.byName(data['tipo']),
      cantidad: data['cantidad'],
      // Convierte el Timestamp de Firestore a DateTime de Dart
      fecha: (data['fecha'] as Timestamp).toDate(),
    );
  }

  // Método para convertir la instancia a un mapa para guardarlo en Firestore
  Map<String, dynamic> toMap() {
    return {
      'productoId': productoId,
      'productoNombre': productoNombre,
      // Convierte el enum a un string para guardarlo
      'tipo': tipo.name,
      'cantidad': cantidad,
      'fecha': Timestamp.fromDate(fecha),
    };
  }
}
