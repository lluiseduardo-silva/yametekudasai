import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:yamete_kudasai/bloc/home_bloc/home_state.dart';
import 'package:yamete_kudasai/bloc/home_bloc/home_event.dart';
import 'package:yamete_kudasai/errors/api.errors.dart';
import 'package:yamete_kudasai/errors/data.errors.dart';
import 'package:yamete_kudasai/external/anitube.service.dart';
import 'package:yamete_kudasai/models/home.model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AnitubeService animeRepo;
  Home animes;
  HomeBloc({this.animeRepo}) : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    switch (event) {
      case HomeEvent.fetchHome:
        yield HomeLoading();
        try {
          animes = await animeRepo.carregarHome();
          yield HomeLoaded(animes: animes);
        } on NoInternetConnection {
          yield HomeOffline();
        } on NotFoundException {
          yield HomeError();
        } on OverRatedException {
          yield HomeError();
        } on DataParseException {
          yield HomeError();
        }
        break;
    }
  }
}
