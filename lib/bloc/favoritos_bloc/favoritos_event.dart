part of 'favoritos_bloc.dart';

abstract class FavoritosEvent extends Equatable {
  const FavoritosEvent();

  @override
  List<Object> get props => [];
}

class InicializarFavoritos extends FavoritosEvent {}

class AdicionarFavorito extends FavoritosEvent {
  final Detalhe dados;
  AdicionarFavorito({this.dados});
}
