part of 'write_page_bloc.dart';

abstract class WritePageEvent extends Equatable {
  const WritePageEvent();

  @override
  List<Object> get props => [];
}

class ToPageWrite extends WritePageEvent {
  var context;
  String id;
  ToPageWrite({required this.context, required this.id});
}

class CheckCurrentUnit extends WritePageEvent {
  String currentUnit;
  CheckCurrentUnit({
    required this.currentUnit,
  });
}

class ConfirmWriteUnit extends WritePageEvent {
  var context;
  String id;
  String statusMeter;
  String currentUnit;
  ConfirmWriteUnit({
    required this.context,
    required this.statusMeter,
    required this.currentUnit,
    required this.id,
  });
}
