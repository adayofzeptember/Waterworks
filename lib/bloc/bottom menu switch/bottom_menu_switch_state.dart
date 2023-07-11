part of 'bottom_menu_switch_bloc.dart';
// ignore_for_file: must_be_immutable
class BottomMenuSwitchState extends Equatable {
  int index;
  BottomMenuSwitchState({required this.index});

  BottomMenuSwitchState copyWith({
    int? index,
  }) {
    return BottomMenuSwitchState(index: index ?? this.index);
  }

  @override
  List<Object> get props => [index];
}
