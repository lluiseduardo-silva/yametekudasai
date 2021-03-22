part of 'stream_bloc.dart';

abstract class StreamEvent extends Equatable {
  const StreamEvent();

  @override
  List<Object> get props => [];
}

class LoadFromUrl extends StreamEvent {
  final String id;
  LoadFromUrl({this.id});
}

class Retry extends StreamEvent {
  Retry();
}
