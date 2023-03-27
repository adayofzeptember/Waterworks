import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'radio_check_event.dart';
part 'radio_check_state.dart';

class RadioCheckBloc extends Bloc<RadioCheckEvent, RadioCheckState> {
  RadioCheckBloc()
  //* default
      : super(RadioCheckState(writeCondition: 'ปกติ', colorCondition: true)) {
    
    on<CheckThisBro>((event, emit) {
      emit(state.copyWith(writeCondition: event.getCondiotionRadio));
      if (state.writeCondition == "ปกติ") {
        emit(state.copyWith(colorCondition: true));
      } else {
        emit(state.copyWith(colorCondition: false));
      }
    
    });

    on<ClearRadioDefault>(
      (event, emit) {
        emit(state.copyWith(writeCondition: 'ปกติ', colorCondition: true));
      },
    );
  }
}
