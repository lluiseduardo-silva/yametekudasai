import 'package:equatable/equatable.dart';
import 'package:yamete_kudasai/models/lista.model.dart';

abstract class ListaState extends Equatable {
  const ListaState();

  @override
  List<Object> get props => [];
}

class ListaInitial extends ListaState {}

class ListaLoading extends ListaState {}

class ListaLoaded extends ListaState {
  final List<Lista> lista;
  ListaLoaded({this.lista});
}

class ListaNextPage extends ListaState {
  final List<Lista> lista;
  ListaNextPage({this.lista});
}

class ListaOffline extends ListaState {}

class ListaOverRated extends ListaState {}

class ListaNoMatch extends ListaState {}

class ListaError extends ListaState {
  final error;
  ListaError({this.error});
}
