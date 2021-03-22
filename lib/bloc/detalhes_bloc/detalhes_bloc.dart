import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamete_kudasai/errors/api.errors.dart';
import 'package:yamete_kudasai/errors/data.errors.dart';
import 'package:yamete_kudasai/external/anitube.service.dart';
import 'package:yamete_kudasai/models/detalhe.model.dart';

part 'detalhes_event.dart';
part 'detalhes_state.dart';

class DetalhesBloc extends Bloc<DetalhesEvent, DetalhesState> {
  final AnitubeService animeRepo;
  Detalhe anime;
  DetalhesBloc({this.animeRepo}) : super(DetalhesInitial());

  @override
  Stream<DetalhesState> mapEventToState(
    DetalhesEvent event,
  ) async* {
    if (event is CarregarDetalhes) {
      if (state is DetalhesLoaded ||
          state is DetalhesInitial ||
          state is DetalhesError ||
          state is DetalhesOffline) {
        yield DetalhesLoading();
        try {
          Detalhe response = await animeRepo.carregarDetalhe(event.id);
          anime = response;
          yield DetalhesLoaded(anime: anime);
        } on OverRatedException {
          yield DetalhesError();
        } on NotFoundException {
          yield DetalhesError();
        } on NoInternetConnection {
          yield DetalhesOffline();
        } on DataParseException {
          yield DetalhesError();
        } catch (e) {
          print(e);
          yield DetalhesError(error: e, url: event.id);
        }
      }
    }
  }
}
