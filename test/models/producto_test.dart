import 'package:flutter_test/flutter_test.dart';
import 'package:inventoryapp/models/producto.dart';

void main() {
  group('Producto serialization', () {
    final Map<String, dynamic> raw = {
      'nombre': 'Camiseta',
      'precio': 19.99,
      'modelos': [
        {
          'modelo': 'TSHIRT-M',
          'opciones': ['Rojo'],
          'especifico': 1,
        },
      ],
    };

    test('fromFirestore builds correctly', () {
      final Producto p = Producto.fromFirestore('abc123', raw);
      expect(p.id, 'abc123');
      expect(p.nombre, 'Camiseta');
      expect(p.precio, 19.99);
      expect(p.modelos.length, 1);
      expect(p.modelos.first.modelo, 'TSHIRT-M');
    });

    test('toMap produces expected map', () {
      final Producto p = Producto.fromFirestore('abc123', raw);
      final Map<String, dynamic> map = p.toMap();
      expect(map['nombre'], raw['nombre']);
      expect(map['precio'], raw['precio']);
      expect(map['modelos'], raw['modelos']);
    });
  });
}