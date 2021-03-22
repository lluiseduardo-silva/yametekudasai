import 'package:equatable/equatable.dart';
import 'package:yamete_kudasai/models/home.model.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Home animes;
  HomeLoaded({this.animes});
}

class HomeOffline extends HomeState {}

class HomeError extends HomeState {
  final error;
  HomeError({this.error});
}
