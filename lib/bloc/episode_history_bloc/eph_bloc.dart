import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamete_kudasai/bloc/episode_history_bloc/modelo.dart';

part 'eph_event.dart';
part 'eph_state.dart';

class EphBloc extends Bloc<EphEvent, EphState> {
  Map<String, HistoricoEpisodio> historico = {};

  EphBloc() : super(EphInitial());
  void _saveHis() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("historico", json.encode(historico));
    });
  }

  @override
  Stream<EphState> mapEventToState(
    EphEvent event,
  ) async* {
    if (event is InicializarHistorico) {
      await SharedPreferences.getInstance().then((prefs) {
        if (prefs.getKeys().contains('historico')) {
          historico =
              json.decode(prefs.getString('historico')).map((key, value) {
            return MapEntry(key, HistoricoEpisodio.fromJson(value));
          }).cast<String, HistoricoEpisodio>();
        }
      });
      print(historico);
      yield EphLoaded(historico);
    }
    if (event is AdicionarHistorico) {
      if (state is EphLoaded) {
        historico[event.key] = new HistoricoEpisodio(
            key: event.key, duration: event.duration, name: event.episodeName);
        _saveHis();
      }
    }
    if (event is Remover) {
      if (historico.containsKey(event.key)) historico.remove(event.key);
      yield EphInitial();
      yield EphLoaded(historico);
    }
    if (event is RefreshState) {
      yield EphInitial();
      historico.values.map((e) {
        print(e.key);
        print(e);
      });
      yield EphLoaded(historico);
    }
  }
}
