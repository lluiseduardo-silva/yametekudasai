import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';

import '../api.dart';

class FavoriteBloc implements BlocBase{
  Map<String, DetalheAnime> _favorites = {};

  final _favController = BehaviorSubject<Map<String, DetalheAnime>>();
  Stream<Map<String, DetalheAnime>> get outFav => _favController.stream;

  FavoriteBloc(){
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getKeys().contains('favoritos')){
        _favorites = json.decode( prefs.getString('favoritos')).map((key, value){
          return MapEntry(key, DetalheAnime.fromJson(value));
        }).cast<String, DetalheAnime>();
        _favController.add(_favorites);
      }
    });
  }
  void toggleFavorite(DetalheAnime dados){
    if(_favorites.containsKey(dados.detalhes.pageLink)) _favorites.remove(dados.detalhes.pageLink);
    else _favorites[dados.detalhes.pageLink] = dados;

    _favController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("favoritos",json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _favController.close();
  }

}