import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_menu_switch_event.dart';
part 'bottom_menu_switch_state.dart';

class BottomMenuSwitchBloc extends Bloc<BottomMenuSwitchEvent, BottomMenuSwitchState> {
  BottomMenuSwitchBloc() : super(BottomMenuSwitchInitial()) {
    on<BottomMenuSwitchEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
