import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';
import '../api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class BuscaBloc implements BlocBase {
  Anitube api;
  List<Dadosbusca> animes;
  bool isWorking = false;

  final _animesController = BehaviorSubject<List<Dadosbusca>>();
  Stream get outAnimes => _animesController.stream;

  final _buscaController = BehaviorSubject<String>();
  Sink get inBusca => _buscaController.sink;

  final _workController = BehaviorSubject<bool>();
  Stream get outWork => _workController.stream;

  BuscaBloc() {
    api = Anitube();

    _buscaController.stream.listen(_busca);
  }

  void _loadNext() async {
    await api.nextBusca().then((value) {
      isWorking = false;
      _workController.sink.add(isWorking);
      animes.addAll(value.animesbusca.dadosbusca);
      _animesController.sink.add(animes);
    }).catchError((error) {
      isWorking = false;
      _workController.sink.add(isWorking);
    });
  }

  void _loadSearch(String s) async {
    _animesController.sink.add([]);
    await api.busca(s).then((value) {
      isWorking = false;
      _workController.sink.add(isWorking);
      animes = value.animesbusca.dadosbusca;
      _animesController.sink.add(animes);
    });
  }

  void _busca(String busca) {
    if (!isWorking) {
      if (busca == null) {
        isWorking = true;
        _workController.sink.add(isWorking);
        _loadNext();
      } else if (busca.isNotEmpty) {
        isWorking = true;
        _workController.sink.add(isWorking);
        _loadSearch(busca);
      }
    }
    print('Aguarde');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animesController.close();
    _buscaController.close();
    _workController.close();
  }
}
