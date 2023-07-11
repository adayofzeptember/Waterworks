// ignore_for_file: must_be_immutable

part of 'radio_check_bloc.dart';
// ค่า state ที่ต้องการให้เปลี่ยน
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
