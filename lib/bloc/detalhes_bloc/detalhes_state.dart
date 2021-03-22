part of 'detalhes_bloc.dart';

abstract class DetalhesState extends Equatable {
  const DetalhesState();

  @override
  List<Object> get props => [];
}

class DetalhesInitial extends DetalhesState {}

class DetalhesLoaded extends DetalhesState {
  final Detalhe anime;
  DetalhesLoaded({this.anime});
}

class DetalhesLoading extends DetalhesState {}

class DetalhesOffline extends DetalhesState {}

class DetalhesError extends DetalhesState {
  final error;
  final String url;
  DetalhesError({this.error, this.url});
}
