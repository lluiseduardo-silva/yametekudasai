import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamete_kudasai/errors/api.errors.dart';
import 'package:yamete_kudasai/errors/data.errors.dart';
import 'package:yamete_kudasai/external/anitube.service.dart';
import 'package:yamete_kudasai/models/lista.model.dart';

part 'busca_event.dart';
part 'busca_state.dart';

class BuscaBloc extends Bloc<BuscaEvent, BuscaState> {
  final AnitubeService animeRepo;
  Exception error;
  List<Lista> busca;
  String query = '';
  BuscaBloc({this.animeRepo}) : super(BuscaInitial());

  @override
  Stream<BuscaState> mapEventToState(
    BuscaEvent event,
  ) async* {
    if (event is BuscarAnime) {
      query = event.busca;
      yield BuscaLoading();
      error = null;
      try {
        var response =
            await animeRepo.carregarBusca(firstPage: true, busca: event.busca);
        busca = response;
        yield BuscaLoaded(busca: busca);
      } on NotFoundException {
        yield BuscaError();
      } on OverRatedException {
        yield BuscaError();
      } on NoHaveData {
        error = Exception();
        yield BuscaLoaded(busca: busca);
      } on DataParseException {
        yield BuscaNotFound();
      } on NoInternetConnection {
        yield BuscaOffline();
      } catch (e) {
        error = e;
        yield BuscaLoaded(busca: busca);
      }
    }
    if (event is ProximaBusca) {
      if (error == null) {
        yield BuscaNextPage(busca: busca);
        try {
          var response =
              await animeRepo.carregarBusca(firstPage: false, busca: query);
          if (response != null) {
            busca.addAll(response);
          }
          yield BuscaLoaded(busca: busca);
        } on NotFoundException {
          yield BuscaError();
        } on OverRatedException {
          yield BuscaError();
        } on NoHaveData {
          error = Exception();
          yield BuscaLoaded(busca: busca);
        } on DataParseException {
          yield BuscaNotFound();
        } on NoInternetConnection {
          yield BuscaOffline();
        } catch (e) {
          error = e;
          yield BuscaLoaded(busca: busca);
        }
      }
    }
  }
}
