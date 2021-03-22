part of 'busca_bloc.dart';

abstract class BuscaEvent extends Equatable {
  const BuscaEvent();

  @override
  List<Object> get props => [];
}

class BuscarAnime extends BuscaEvent {
  final String busca;

  BuscarAnime(this.busca);
}

class ProximaBusca extends BuscaEvent {}
