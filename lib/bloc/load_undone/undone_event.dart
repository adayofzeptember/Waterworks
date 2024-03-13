// ignore_for_file: must_be_immutable

part of 'undone_bloc.dart';

abstract class NotWriteEvent extends Equatable {
  const NotWriteEvent();

  @override
  List<Object> get props => [];
}

class Load_unDoneData extends NotWriteEvent {}

class Reload_Undone extends NotWriteEvent {}

class FilterData extends NotWriteEvent {
  String id;
  int segmentActive;
  // bool stopLoad;
  FilterData({required this.id, required this.segmentActive});
}

class BackMenu extends NotWriteEvent {}
