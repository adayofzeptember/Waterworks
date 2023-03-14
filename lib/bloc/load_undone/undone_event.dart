part of 'undone_bloc.dart';

abstract class NotWriteEvent extends Equatable {
  const NotWriteEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends NotWriteEvent {}

