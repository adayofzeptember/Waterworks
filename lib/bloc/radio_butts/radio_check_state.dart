part of 'radio_check_bloc.dart';

class RadioCheckState extends Equatable {
  String writeCondition;
  bool colorCondition;

  RadioCheckState({required this.writeCondition, required this.colorCondition});

  RadioCheckState copyWith({String? writeCondition, bool? colorCondition}) {
    return RadioCheckState(
        writeCondition: writeCondition ?? this.writeCondition,
        colorCondition: colorCondition ?? this.colorCondition);
  }

  @override
  List<Object> get props => [writeCondition, colorCondition];
}
