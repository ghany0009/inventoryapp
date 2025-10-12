
class Modelo {
  final String modelo;          //  "telefono"
  final List<String> opciones; //  ["Negro", "Gris"]
  final int especifico;         // cualquier entero que identifique la variante

  Modelo({
    required this.modelo,
    required this.opciones,
    required this.especifico,
  });

  
  //  copyWith para Modelo
  
  Modelo copyWith({
    String? modelo,
    List<String>? opciones,
    int? especifico,
  }) {
    return Modelo(
      modelo: modelo ?? this.modelo,
      opciones: opciones ?? this.opciones,
      especifico: especifico ?? this.especifico,
    );
  }

  
  //  FROM MAP
  
  factory Modelo.fromMap(Map<String, dynamic> data) {
    final String modelo = data['modelo'] as String;
    final List<dynamic> rawOpciones = data['opciones'] as List<dynamic>;
    final List<String> opciones =
        rawOpciones.map((e) => e as String).toList();
    final int especifico = data['especifico'] as int;

    return Modelo(
      modelo: modelo,
      opciones: opciones,
      especifico: especifico,
    );
  }

  //  TO MAP

  Map<String, dynamic> toMap() => {
        'modelo': modelo,
        'opciones': opciones,
        'especifico': especifico,
      };
}