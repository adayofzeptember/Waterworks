part of 'done_bloc.dart';
// ignore_for_file: must_be_immutable
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
  FilterData({required this.id, required this.segmentActive});
}
