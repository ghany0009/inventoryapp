class Producto {
  final String id;
  final String nombre;
  final String descripcion;
  final String categoria;
  final int stock;
  final double precio;

  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.categoria,
    required this.stock,
    required this.precio,
  });

  factory Producto.fromMap(String id, Map<String, dynamic> data) {
    return Producto(
      id: id,
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      categoria: data['categoria'],
      stock: data['stock'],
      precio: (data['precio'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'categoria': categoria,
      'stock': stock,
      'precio': precio,
    };
  }
}
