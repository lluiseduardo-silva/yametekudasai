part of 'eph_bloc.dart';

abstract class EphState extends Equatable {
  const EphState();

  @override
  List<Object> get props => [];
}

class EphInitial extends EphState {}

class EphLoaded extends EphState {
  final Map<String, HistoricoEpisodio> historico;
  EphLoaded(this.historico);
}

class EphLoading extends EphState {}
