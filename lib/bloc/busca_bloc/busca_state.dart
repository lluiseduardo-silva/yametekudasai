part of 'busca_bloc.dart';

abstract class BuscaState extends Equatable {
  const BuscaState();

  @override
  List<Object> get props => [];
}

class BuscaInitial extends BuscaState {}

class BuscaLoading extends BuscaState {}

class BuscaLoaded extends BuscaState {
  final List<Lista> busca;

  BuscaLoaded({this.busca});
}

class BuscaNextPage extends BuscaState {
  final List<Lista> busca;
  BuscaNextPage({this.busca});
}

class BuscaNotFound extends BuscaState {}

class BuscaError extends BuscaState {}

class BuscaOffline extends BuscaState {}
