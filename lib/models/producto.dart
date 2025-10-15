import 'package:inventoryapp/models/modelo.dart';

class Producto {
  final String id; // id del documento en Firestore
  final String nombre;
  final double precio;
  final List<Modelo> modelos;
  final int stock; // composición → lista de variantes

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.modelos,
    this.stock = 0,
  });

  /// Crea una instancia cambiando solo los campos indicados
  Producto copyWith({
    String? id,
    String? nombre,
    double? precio,
    List<Modelo>? modelos,
    int? stock,
  }) {
    return Producto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      modelos: modelos ?? this.modelos,
      stock: stock ?? this.stock,
    );
  }
  //  FACTORY FROM FIRESTORE (des‑serialización)

  factory Producto.fromFirestore(String id, Map<String, dynamic> data) {
    return Producto(
      id: id,
      nombre: data['nombre'] as String,
      precio: (data['precio'] as num).toDouble(),
      modelos: (data['modelos'] as List<dynamic>)
          .map((m) => Modelo.fromMap(m as Map<String, dynamic>))
          .toList(),
      stock: data['stock'] ?? 0,
    );
  }

  Null get name => null;

  //  TO MAP (serialización)

  Map<String, dynamic> toMap() => {
    'nombre': nombre,
    'precio': precio,
    'modelos': modelos.map((m) => m.toMap()).toList(),
    'stock': stock,
  };
}
