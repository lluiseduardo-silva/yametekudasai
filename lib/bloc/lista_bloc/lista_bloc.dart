import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:yamete_kudasai/errors/api.errors.dart';
import 'package:yamete_kudasai/errors/data.errors.dart';
import 'package:yamete_kudasai/external/anitube.service.dart';
import 'package:yamete_kudasai/models/lista.model.dart';
import 'lista_state.dart';
import 'lista_event.dart';

class ListaBloc extends Bloc<ListaEvent, ListaState> {
  final AnitubeService animeRepo;
  List<Lista> animes;
  bool error;
  String lastSearch;
  ListaBloc({this.animeRepo}) : super(ListaInitial());

  @override
  Stream<ListaState> mapEventToState(
    ListaEvent event,
  ) async* {
    if (event is LoadDub) {
      try {
        lastSearch = event.letra;
        error = false;
        yield ListaLoading();
        var response = await animeRepo.carregarDublados(
            firstPage: true, letra: event.letra);
        animes = response;
        yield ListaLoaded(lista: animes);
      } on OverRatedException {
        yield ListaOverRated();
      } on NotFoundException {
        yield ListaError();
      } on NoHaveData {
        error = true;
        yield ListaLoaded(lista: animes);
      } on NoInternetConnection {
        yield ListaOffline();
      } on DataParseException {
        yield ListaNoMatch();
      }
    }
    if (event is LoadDubNext) {
      if (!error) {
        if (state is ListaLoaded) {
          try {
            yield ListaNextPage(lista: animes);
            var response = await animeRepo.carregarDublados(
                firstPage: false, letra: lastSearch);
            animes.addAll(response);
            yield ListaLoaded(lista: animes);
          } on NotFoundException {
            yield ListaError();
          } on OverRatedException {
            yield ListaOverRated();
          } on NoHaveData {
            error = true;
            yield ListaLoaded(lista: animes);
          } on NoInternetConnection {
            yield ListaOffline();
          } on DataParseException {
            yield ListaError();
          }
        }
      }
    }
    if (event is LoadSub) {
      try {
        lastSearch = event.letra;
        error = false;
        yield ListaLoading();
        animes = await animeRepo.carregarLegendados(
            firstPage: true, letra: event.letra);
        yield ListaLoaded(lista: animes);
      } on OverRatedException {
        yield ListaOverRated();
      } on NotFoundException {
        yield ListaError();
      } on NoHaveData {
        error = true;
        yield ListaLoaded(lista: animes);
      } on NoInternetConnection {
        yield ListaOffline();
      } on DataParseException {
        yield ListaError();
      }
    }
    if (event is LoadSubNext) {
      if (!error) {
        if (state is ListaLoaded) {
          try {
            yield ListaNextPage(lista: animes);
            var response = await animeRepo.carregarLegendados(
                firstPage: false, letra: lastSearch);
            animes.addAll(response);
            yield ListaLoaded(lista: animes);
          } on OverRatedException {
            yield ListaOverRated();
          } on NotFoundException {
            yield ListaError();
          } on NoHaveData {
            error = true;
            yield ListaLoaded(lista: animes);
          } on NoInternetConnection {
            yield ListaOffline();
          } on DataParseException {
            yield ListaError();
          }
        }
      }
    }
  }
}
