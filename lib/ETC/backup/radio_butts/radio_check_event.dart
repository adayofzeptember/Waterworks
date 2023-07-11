// ignore_for_file: must_be_immutable

part of 'radio_check_bloc.dart';

abstract class RadioCheckEvent extends Equatable {
  const RadioCheckEvent();

  @override
  List<Object> get props => [];
}


class CheckThisBro extends RadioCheckEvent {
  String getCondiotionRadio;
  //ตัวแปรจาก event
  CheckThisBro({
    required this.getCondiotionRadio,
  });
}


class ClearRadioDefault extends RadioCheckEvent{
  ClearRadioDefault ();
}
