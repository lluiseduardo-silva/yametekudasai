import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamete_kudasai/errors/api.errors.dart';
import 'package:yamete_kudasai/errors/data.errors.dart';
import 'package:yamete_kudasai/external/anitube.service.dart';
import 'package:yamete_kudasai/models/stream.model.dart';

part 'stream_event.dart';
part 'stream_state.dart';

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  AnimeStream fontes;
  String epAtual;
  final AnitubeService animeRepo;
  StreamBloc({this.animeRepo}) : super(StreamInitial());

  @override
  Stream<StreamState> mapEventToState(
    StreamEvent event,
  ) async* {
    if (event is LoadFromUrl) {
      if (state is StreamLoaded ||
          state is StreamInitial ||
          state is StreamError) {
        yield StreamLoading();
        try {
          var response = await animeRepo.carregarStream(event.id);

          fontes = response;
          epAtual = event.id;
          yield StreamLoaded(stream: fontes);
        } on OverRatedException {
          yield StreamError();
        } on NotFoundException {
          yield StreamError();
        } on NoInternetConnection {
          yield StreamOffline();
        } on DataParseException {
          yield StreamError();
        }
      }
    }
    if (event is Retry) {
      yield StreamLoading();
      try {
        var response = await animeRepo.carregarStream(epAtual);
        fontes = response;
        yield StreamLoaded(stream: fontes);
      } catch (e) {
        print(e);
        yield StreamError(url: epAtual);
      }
    }
  }
}
