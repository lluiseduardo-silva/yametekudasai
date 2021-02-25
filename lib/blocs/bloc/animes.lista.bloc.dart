import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';
import '../api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class ListaBloc implements BlocBase {
  Anitube api;
  List<Dadoslista> animes;
  bool isWorking = false;

  final _animeController = BehaviorSubject<List<Dadoslista>>();
  Stream get outAnimes => _animeController.stream;

  final _loadController = BehaviorSubject<String>();
  Sink get inLoad => _loadController.sink;

  final _workController = BehaviorSubject<bool>();
  Stream get outWork => _workController.stream;

  ListaBloc() {
    api = Anitube();
    _init();
    _loadController.stream.listen(_next);
  }
  // void _reset(String s) async {
  //   isWorking = true;
  //   _workController.sink.add(isWorking);
  //   await api.carregarLista('').then((value) {
  //     animes = value.animeslista.dadoslista;
  //     _animeController.sink.add(animes);
  //     isWorking = false;
  //     _workController.sink.add(isWorking);
  //   });
  // }

  void _init() async {
    isWorking = true;
    _workController.sink.add(isWorking);
    await api.carregarLista('').then((value) {
      animes = value.animeslista.dadoslista;
      _animeController.sink.add(animes);
      isWorking = false;
      _workController.sink.add(isWorking);
    });
  }

  void _next(String s) async {
    if (isWorking == false) {
      isWorking = true;
      _workController.sink.add(isWorking);
      await api.carregarLista('aaa').then((value) {
        isWorking = false;
        animes.addAll(value.animeslista.dadoslista);
        _animeController.sink.add(animes);
        _workController.sink.add(isWorking);
      }).catchError((error) {
        isWorking = false;
        _workController.sink.add(isWorking);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animeController.close();
    _loadController.close();
    _workController.close();
  }
}
