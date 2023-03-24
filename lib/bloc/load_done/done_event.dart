part of 'done_bloc.dart';

abstract class DoneEvent extends Equatable {
  const DoneEvent();

  @override
  List<Object> get props => [];
}

class Load_DoneData extends DoneEvent {}

class Reload_Done extends DoneEvent {}

class FilterData extends DoneEvent {
  String id;
  int segmentActive;
  bool stopLoad;
  FilterData({required this.id, required this.segmentActive, required this.stopLoad});
}
