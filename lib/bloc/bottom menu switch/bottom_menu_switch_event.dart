part of 'bottom_menu_switch_bloc.dart';

abstract class BottomMenuSwitchEvent extends Equatable {
  const BottomMenuSwitchEvent();

  @override
  List<Object> get props => [];
}

class SwitchIndex extends BottomMenuSwitchEvent {
  int getIndex;

  SwitchIndex({required this.getIndex});
}
