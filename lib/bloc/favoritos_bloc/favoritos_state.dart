part of 'favoritos_bloc.dart';

abstract class FavoritosState extends Equatable {
  const FavoritosState();

  @override
  List<Object> get props => [];
}

class FavoritosInitial extends FavoritosState {}

class FavoritosLoaded extends FavoritosState {
  final Map<String, Detalhe> favoritos;
  FavoritosLoaded({this.favoritos});
}
