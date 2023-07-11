// ignore_for_file: must_be_immutable

part of 'checkbox_bloc.dart';

abstract class CheckboxEvent extends Equatable {
  const CheckboxEvent();

  @override
  List<Object> get props => [];
}

class CheckThisShit extends CheckboxEvent {
  bool checkkamic;
  CheckThisShit({
    required this.checkkamic,
  });
}

class ClearCheck extends CheckboxEvent {
  // var context;
  ClearCheck();
}

