part of 'detalhes_bloc.dart';

abstract class DetalhesEvent extends Equatable {
  const DetalhesEvent();

  @override
  List<Object> get props => [];
}

class CarregarDetalhes extends DetalhesEvent {
  final String id;
  CarregarDetalhes({this.id});
}
