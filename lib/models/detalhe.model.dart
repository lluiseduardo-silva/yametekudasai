import 'dart:convert';

import 'package:collection/collection.dart';

class Detalhe {
  String titulo;
  String capa;
  String sinopse;
  String id;
  List<Episodio> episodios;
  Detalhe({
    this.titulo,
    this.capa,
    this.sinopse,
    this.id,
    this.episodios,
  });

  Detalhe copyWith({
    String titulo,
    String capa,
    String sinopse,
    String id,
    List<Episodio> episodios,
  }) {
    return Detalhe(
      titulo: titulo ?? this.titulo,
      capa: capa ?? this.capa,
      sinopse: sinopse ?? this.sinopse,
      id: id ?? this.id,
      episodios: episodios ?? this.episodios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'capa': capa,
      'sinopse': sinopse,
      'id': id,
      'episodios': episodios?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Detalhe.fromMap(Map<String, dynamic> map) {
    return Detalhe(
      titulo: map['titulo'],
      capa: map['capa'],
      sinopse: map['sinopse'],
      id: map['id'],
      episodios: List<Episodio>.from(
          map['episodios']?.map((x) => Episodio.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Detalhe.fromJson(String source) =>
      Detalhe.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Detalhe(titulo: $titulo, capa: $capa, sinopse: $sinopse, id: $id, episodios: $episodios)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Detalhe &&
        other.titulo == titulo &&
        other.capa == capa &&
        other.sinopse == sinopse &&
        other.id == id &&
        listEquals(other.episodios, episodios);
  }

  @override
  int get hashCode {
    return titulo.hashCode ^
        capa.hashCode ^
        sinopse.hashCode ^
        id.hashCode ^
        episodios.hashCode;
  }
}

class Episodio {
  String titulo;
  String id;
  Episodio({
    this.titulo,
    this.id,
  });

  Episodio copyWith({
    String titulo,
    String id,
  }) {
    return Episodio(
      titulo: titulo ?? this.titulo,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'id': id,
    };
  }

  factory Episodio.fromMap(Map<String, dynamic> map) {
    return Episodio(
      titulo: map['titulo'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Episodio.fromJson(String source) =>
      Episodio.fromMap(json.decode(source));

  @override
  String toString() => 'Episodio(titulo: $titulo, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Episodio && other.titulo == titulo && other.id == id;
  }

  @override
  int get hashCode => titulo.hashCode ^ id.hashCode;
}
