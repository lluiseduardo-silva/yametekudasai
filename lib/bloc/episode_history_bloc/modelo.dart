import 'dart:convert';

import 'package:flutter/foundation.dart';

class HistoricoEpisodio {
  String key;
  String name;
  int duration;
  HistoricoEpisodio({
    @required this.key,
    @required this.name,
    @required this.duration,
  });

  HistoricoEpisodio copyWith({
    String key,
    String name,
    int duration,
  }) {
    return HistoricoEpisodio(
      key: key ?? this.key,
      name: name ?? this.name,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'name': name,
      'duration': duration,
    };
  }

  factory HistoricoEpisodio.fromMap(Map<String, dynamic> map) {
    return HistoricoEpisodio(
      key: map['key'],
      name: map['name'],
      duration: map['duration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoricoEpisodio.fromJson(String source) =>
      HistoricoEpisodio.fromMap(json.decode(source));

  @override
  String toString() =>
      'HistoricoEpisodio(key: $key, name: $name, duration: $duration)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoricoEpisodio &&
        other.key == key &&
        other.name == name &&
        other.duration == duration;
  }

  @override
  int get hashCode => key.hashCode ^ name.hashCode ^ duration.hashCode;
}
