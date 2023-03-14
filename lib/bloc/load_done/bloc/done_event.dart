part of 'done_bloc.dart';

abstract class DoneEvent extends Equatable {
  const DoneEvent();

  @override
  List<Object> get props => [];
}
class Load_DoneData extends DoneEvent {}