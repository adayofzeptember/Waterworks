import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checkbox_event.dart';
part 'checkbox_state.dart';

class CheckboxBloc extends Bloc<CheckboxEvent, CheckboxState> {
  CheckboxBloc() : super(CheckboxState(isCheckbloc: false)) {
    on<CheckThisShit>((event, emit) {
      emit(state.copyWith(isCheckbloc: event.checkkamic));
      print('bloc-----' + state.isCheckbloc.toString());
    });

    on<ClearCheck>(
      (event, emit) {
        emit(state.copyWith(isCheckbloc: false));
      },
    );
  }
}
