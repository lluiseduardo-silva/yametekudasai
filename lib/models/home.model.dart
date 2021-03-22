import 'dart:convert';
import 'dart:core';

import 'package:collection/collection.dart';

class Home {
  List<MaisAssistidos> populares;
  List<Episodios> episodios;
  List<Novos> animesNovos;
  List<AnimesRecentes> animesRecentes;
  Home({
    this.populares,
    this.episodios,
    this.animesNovos,
    this.animesRecentes,
  });

  Home copyWith({
    List<MaisAssistidos> populares,
    List<Episodios> episodios,
    List<Novos> animesNovos,
    List<AnimesRecentes> animesRecentes,
  }) {
    return Home(
      populares: populares ?? this.populares,
      episodios: episodios ?? this.episodios,
      animesNovos: animesNovos ?? this.animesNovos,
      animesRecentes: animesRecentes ?? this.animesRecentes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'populares': populares?.map((x) => x.toMap())?.toList(),
      'episodios': episodios?.map((x) => x.toMap())?.toList(),
      'animesNovos': animesNovos?.map((x) => x.toMap())?.toList(),
      'animesRecentes': animesRecentes?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Home.fromMap(Map<String, dynamic> map) {
    return Home(
      populares: List<MaisAssistidos>.from(
          map['populares']?.map((x) => MaisAssistidos.fromMap(x))),
      episodios: List<Episodios>.from(
          map['episodios']?.map((x) => Episodios.fromMap(x))),
      animesNovos:
          List<Novos>.from(map['animesNovos']?.map((x) => Novos.fromMap(x))),
      animesRecentes: List<AnimesRecentes>.from(
          map['animesRecentes']?.map((x) => AnimesRecentes.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Home.fromJson(String source) => Home.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Home(populares: $populares, episodios: $episodios, animesNovos: $animesNovos, animesRecentes: $animesRecentes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Home &&
        listEquals(other.populares, populares) &&
        listEquals(other.episodios, episodios) &&
        listEquals(other.animesNovos, animesNovos) &&
        listEquals(other.animesRecentes, animesRecentes);
  }

  @override
  int get hashCode {
    return populares.hashCode ^
        episodios.hashCode ^
        animesNovos.hashCode ^
        animesRecentes.hashCode;
  }
}

class MaisAssistidos {
  String titulo;
  String id;
  String capa;
  MaisAssistidos({
    this.titulo,
    this.id,
    this.capa,
  });

  MaisAssistidos copyWith({
    String titulo,
    String id,
    String capa,
  }) {
    return MaisAssistidos(
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

  factory MaisAssistidos.fromMap(Map<String, dynamic> map) {
    return MaisAssistidos(
      titulo: map['titulo'],
      id: map['id'],
      capa: map['capa'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MaisAssistidos.fromJson(String source) =>
      MaisAssistidos.fromMap(json.decode(source));

  @override
  String toString() => 'MaisAssistidos(titulo: $titulo, id: $id, capa: $capa)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MaisAssistidos &&
        other.titulo == titulo &&
        other.id == id &&
        other.capa == capa;
  }

  @override
  int get hashCode => titulo.hashCode ^ id.hashCode ^ capa.hashCode;
}

class Episodios {
  String titulo;
  String id;
  String capa;
  Episodios({
    this.titulo,
    this.id,
    this.capa,
  });

  Episodios copyWith({
    String titulo,
    String id,
    String capa,
  }) {
    return Episodios(
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

  factory Episodios.fromMap(Map<String, dynamic> map) {
    return Episodios(
      titulo: map['titulo'],
      id: map['id'],
      capa: map['capa'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Episodios.fromJson(String source) =>
      Episodios.fromMap(json.decode(source));

  @override
  String toString() => 'Episodios(titulo: $titulo, id: $id, capa: $capa)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Episodios &&
        other.titulo == titulo &&
        other.id == id &&
        other.capa == capa;
  }

  @override
  int get hashCode => titulo.hashCode ^ id.hashCode ^ capa.hashCode;
}

class Novos {
  String titulo;
  String id;
  String capa;
  Novos({
    this.titulo,
    this.id,
    this.capa,
  });

  Novos copyWith({
    String titulo,
    String id,
    String capa,
  }) {
    return Novos(
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

  factory Novos.fromMap(Map<String, dynamic> map) {
    return Novos(
      titulo: map['titulo'],
      id: map['id'],
      capa: map['capa'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Novos.fromJson(String source) => Novos.fromMap(json.decode(source));

  @override
  String toString() => 'Novos(titulo: $titulo, id: $id, capa: $capa)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Novos &&
        other.titulo == titulo &&
        other.id == id &&
        other.capa == capa;
  }

  @override
  int get hashCode => titulo.hashCode ^ id.hashCode ^ capa.hashCode;
}

class AnimesRecentes {
  String titulo;
  String id;
  String capa;
  AnimesRecentes({
    this.titulo,
    this.id,
    this.capa,
  });

  AnimesRecentes copyWith({
    String titulo,
    String id,
    String capa,
  }) {
    return AnimesRecentes(
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

  factory AnimesRecentes.fromMap(Map<String, dynamic> map) {
    return AnimesRecentes(
      titulo: map['titulo'],
      id: map['id'],
      capa: map['capa'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimesRecentes.fromJson(String source) =>
      AnimesRecentes.fromMap(json.decode(source));

  @override
  String toString() => 'AnimesRecentes(titulo: $titulo, id: $id, capa: $capa)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnimesRecentes &&
        other.titulo == titulo &&
        other.id == id &&
        other.capa == capa;
  }

  @override
  int get hashCode => titulo.hashCode ^ id.hashCode ^ capa.hashCode;
}
