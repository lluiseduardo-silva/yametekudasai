part of 'stream_bloc.dart';

abstract class StreamState extends Equatable {
  const StreamState();

  @override
  List<Object> get props => [];
}

class StreamInitial extends StreamState {}

class StreamLoaded extends StreamState {
  final AnimeStream stream;
  StreamLoaded({this.stream});
}

class StreamLoading extends StreamState {}

class StreamOffline extends StreamState {}

class StreamError extends StreamState {
  final String url;
  StreamError({this.url});
}
