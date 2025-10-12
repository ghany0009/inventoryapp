// test/models/modelo_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:inventoryapp/models/modelo.dart';

void main() {
  group('Modelo serialization', () {
    final raw = {
      'modelo': 'Telefono',
      'opciones': ['Rojo', 'Azul'],
      'especifico': 7,
    };

    test('fromMap builds correctly', () {
      final m = Modelo.fromMap(raw);
      expect(m.modelo, 'Telefono');
      expect(m.opciones, ['Rojo', 'Azul']);
      expect(m.especifico, 7);
    });

    test('toMap returns identical map', () {
      final m = Modelo.fromMap(raw);
      expect(m.toMap(), raw);
    });
  });
}