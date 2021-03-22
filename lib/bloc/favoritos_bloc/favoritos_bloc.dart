import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamete_kudasai/models/detalhe.model.dart';

part 'favoritos_event.dart';
part 'favoritos_state.dart';

class FavoritosBloc extends Bloc<FavoritosEvent, FavoritosState> {
  Map<String, Detalhe> favoritos = {};

  FavoritosBloc() : super(FavoritosInitial());

  void toggleFavorite(Detalhe dados) {
    print(favoritos.entries);
    if (favoritos.containsKey(dados.id))
      favoritos.remove(dados.id);
    else
      favoritos[dados.id] = dados;
    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favoritos", json.encode(favoritos));
    });
  }

  @override
  Stream<FavoritosState> mapEventToState(
    FavoritosEvent event,
  ) async* {
    if (event is InicializarFavoritos) {
      await SharedPreferences.getInstance().then((prefs) {
        if (prefs.getKeys().contains('favoritos')) {
          favoritos =
              json.decode(prefs.getString('favoritos')).map((key, value) {
            return MapEntry(key, Detalhe.fromJson(value));
          }).cast<String, Detalhe>();
        }
      });
      yield FavoritosLoaded(favoritos: favoritos);
    }
    if (event is AdicionarFavorito) {
      toggleFavorite(event.dados);
      yield FavoritosInitial();
      yield FavoritosLoaded(favoritos: favoritos);
    }
  }
}
