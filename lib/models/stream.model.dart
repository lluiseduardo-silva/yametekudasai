import 'dart:convert';
import 'package:flutter/foundation.dart';

class AnimeStream {
  String titulo;
  String id;
  String nextEpName;
  String nextEpLink;
  String backEpName;
  String backEpLink;
  String detalhes;
  List<Fontes> fontes;
  AnimeStream({
    this.titulo,
    this.id,
    this.nextEpName,
    this.nextEpLink,
    this.backEpName,
    this.backEpLink,
    this.detalhes,
    this.fontes,
  });

  AnimeStream copyWith({
    String titulo,
    String id,
    String nextEpName,
    String nextEpLink,
    String backEpName,
    String backEpLink,
    String detalhes,
    List<Fontes> fontes,
  }) {
    return AnimeStream(
      titulo: titulo ?? this.titulo,
      id: id ?? this.id,
      nextEpName: nextEpName ?? this.nextEpName,
      nextEpLink: nextEpLink ?? this.nextEpLink,
      backEpName: backEpName ?? this.backEpName,
      backEpLink: backEpLink ?? this.backEpLink,
      detalhes: detalhes ?? this.detalhes,
      fontes: fontes ?? this.fontes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'id': id,
      'nextEpName': nextEpName,
      'nextEpLink': nextEpLink,
      'backEpName': backEpName,
      'backEpLink': backEpLink,
      'detalhes': detalhes,
      'fontes': fontes?.map((x) => x.toMap())?.toList(),
    };
  }

  factory AnimeStream.fromMap(Map<String, dynamic> map) {
    return AnimeStream(
      titulo: map['titulo'],
      id: map['id'],
      nextEpName: map['nextEpName'],
      nextEpLink: map['nextEpLink'],
      backEpName: map['backEpName'],
      backEpLink: map['backEpLink'],
      detalhes: map['detalhes'],
      fontes: List<Fontes>.from(map['fontes']?.map((x) => Fontes.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeStream.fromJson(String source) =>
      AnimeStream.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AnimeStream(titulo: $titulo, id: $id, nextEpName: $nextEpName, nextEpLink: $nextEpLink, backEpName: $backEpName, backEpLink: $backEpLink, detalhes: $detalhes, fontes: $fontes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnimeStream &&
        other.titulo == titulo &&
        other.id == id &&
        other.nextEpName == nextEpName &&
        other.nextEpLink == nextEpLink &&
        other.backEpName == backEpName &&
        other.backEpLink == backEpLink &&
        other.detalhes == detalhes &&
        listEquals(other.fontes, fontes);
  }

  @override
  int get hashCode {
    return titulo.hashCode ^
        id.hashCode ^
        nextEpName.hashCode ^
        nextEpLink.hashCode ^
        backEpName.hashCode ^
        backEpLink.hashCode ^
        detalhes.hashCode ^
        fontes.hashCode;
  }
}

class Fontes {
  String file;
  String label;
  String type;
  Fontes({
    this.file,
    this.label,
    this.type,
  });

  Fontes copyWith({
    String file,
    String label,
    String type,
  }) {
    return Fontes(
      file: file ?? this.file,
      label: label ?? this.label,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'file': file,
      'label': label,
      'type': type,
    };
  }

  factory Fontes.fromMap(Map<String, dynamic> map) {
    return Fontes(
      file: map['file'],
      label: map['label'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Fontes.fromJson(String source) => Fontes.fromMap(json.decode(source));

  @override
  String toString() => 'Fontes(file: $file, label: $label, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Fontes &&
        other.file == file &&
        other.label == label &&
        other.type == type;
  }

  @override
  int get hashCode => file.hashCode ^ label.hashCode ^ type.hashCode;
}
