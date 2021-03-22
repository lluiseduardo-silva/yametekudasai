import 'package:equatable/equatable.dart';

abstract class ListaEvent extends Equatable {
  const ListaEvent();

  @override
  List<Object> get props => [];
}

class LoadDub extends ListaEvent {
  final String letra;

  LoadDub({this.letra});
}

class LoadDubNext extends ListaEvent {}

class LoadSub extends ListaEvent {
  final String letra;

  LoadSub({this.letra});
}

class LoadSubNext extends ListaEvent {}
