import 'dart:convert';

class Lista {
  String titulo;
  String id;
  String capa;
  Lista({
    this.titulo,
    this.id,
    this.capa,
  });

  Lista copyWith({
    String titulo,
    String id,
    String capa,
  }) {
    return Lista(
      titulo: titulo ?? this.titulo,
      id: id ?? this.id,
      capa: capa ?? this.capa,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'id': id,
      'capa': capa,
    };
  }

  factory Lista.fromMap(Map<String, dynamic> map) {
    return Lista(
      titulo: map['titulo'],
      id: map['id'],
      capa: map['capa'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Lista.fromJson(String source) => Lista.fromMap(json.decode(source));

  @override
  String toString() => 'Lista(titulo: $titulo, id: $id, capa: $capa)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Lista &&
        other.titulo == titulo &&
        other.id == id &&
        other.capa == capa;
  }

  @override
  int get hashCode => titulo.hashCode ^ id.hashCode ^ capa.hashCode;
}
