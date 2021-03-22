part of 'eph_bloc.dart';

abstract class EphEvent extends Equatable {
  const EphEvent();

  @override
  List<Object> get props => [];
}

class AdicionarHistorico extends EphEvent {
  final String key;
  final int duration;
  final String episodeName;
  AdicionarHistorico({this.key, this.duration, this.episodeName});
}

class InicializarHistorico extends EphEvent {}

class Remover extends EphEvent {
  final String key;

  Remover({this.key});
}

class RefreshState extends EphEvent {}
