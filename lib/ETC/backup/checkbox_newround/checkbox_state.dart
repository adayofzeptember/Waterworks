// ignore_for_file: must_be_immutable

part of 'checkbox_bloc.dart';

class CheckboxState extends Equatable {
  bool isCheckbloc;

  CheckboxState({required this.isCheckbloc});

  CheckboxState copyWith({
    bool? isCheckbloc,
  }) {
    return CheckboxState(isCheckbloc: isCheckbloc ?? this.isCheckbloc);
  }

  @override
  List<Object> get props => [isCheckbloc];
}

// class CheckboxInitial extends CheckboxState {}
