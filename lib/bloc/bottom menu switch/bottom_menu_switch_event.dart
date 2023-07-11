part of 'bottom_menu_switch_bloc.dart';
// ignore_for_file: must_be_immutable
abstract class BottomMenuSwitchEvent extends Equatable {
  const BottomMenuSwitchEvent();

  @override
  List<Object> get props => [];
}

class SwitchIndex extends BottomMenuSwitchEvent {
  int getIndex;

  SwitchIndex({required this.getIndex});
}
