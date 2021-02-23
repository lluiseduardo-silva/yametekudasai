import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';
import '../api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class HomeBloc extends BlocBase {
  Anitube api;
  List<MaisAssistidos> mais;
  List<Adicionados> adc;
  List<EpisodiosRecentes> eps;

  final _maisController = BehaviorSubject<List<MaisAssistidos>>();
  Stream get outMore => _maisController.stream;

  final _adcController = BehaviorSubject<List<Adicionados>>();
  Stream get outLan => _adcController.stream;

  final _epsController = BehaviorSubject<List<EpisodiosRecentes>>();
  Stream get outEps => _epsController.stream;

  HomeBloc() {
    api = new Anitube();
    _init();
  }

  _init() async {
    Home response = await api.carregarHome();
    mais = response.animes.maisAssistidos;
    eps = response.animes.episodiosRecentes;
    adc = response.animes.adicionados;
    _maisController.sink.add(mais);
    _epsController.sink.add(eps);
    _adcController.sink.add(adc);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _epsController.close();
    _adcController.close();
    _maisController.close();
  }
}
