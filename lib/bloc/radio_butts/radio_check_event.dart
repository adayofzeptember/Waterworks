part of 'radio_check_bloc.dart';

abstract class RadioCheckEvent extends Equatable {
  const RadioCheckEvent();

  @override
  List<Object> get props => [];
}


class CheckThisBro extends RadioCheckEvent {
  String getCondiotionRadio;
  CheckThisBro({
    required this.getCondiotionRadio,
  });
}


class ClearRadioDefault extends RadioCheckEvent{
  ClearRadioDefault ();
}
