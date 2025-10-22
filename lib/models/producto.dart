import 'package:inventoryapp/models/modelo.dart';

class Producto {
  final String? id; // id del documento en Firestore, la ? hace que sea opcional
  final String nombre;
  final double precio;
  final List<Modelo> modelos;
  final int stock; // composición → lista de variantes, valor por defecto 0

  Producto({
    required this.id, // opcional para nuevos productos
    required this.nombre,
    required this.precio,
    required this.modelos,
    this.stock = 0,
  });

  String get name =>
      nombre; // getter para obtener el nombre, antes devolvia null

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
      // Creamos una copia de la lista para evitar efectos secundarios
      modelos: modelos ?? List<Modelo>.from(this.modelos),
      stock: stock ?? this.stock,
    );
  }
  //  FACTORY FROM FIRESTORE (des‑serialización)

  factory Producto.fromFirestore(String id, Map<String, dynamic> data) {
    // Seguridad ante campos ausentes o nulos
    final rawModelos = data['modelos'] as List<dynamic>? ?? [];

    return Producto(
      id: id,
      nombre: data['nombre'] as String? ?? '',
      precio: (data['precio'] as num?)?.toDouble() ?? 0.0,
      modelos: rawModelos
          .map((m) => Modelo.fromMap(m as Map<String, dynamic>))
          .toList(),
      stock: data['stock'] ?? 0,
    );
  }

  //  TO MAP (serialización) para guardar en Firestore

  Map<String, dynamic> toMap() => {
    'nombre': nombre,
    'precio': precio,
    'modelos': modelos.map((m) => m.toMap()).toList(),
    'stock': stock,
  };
}
