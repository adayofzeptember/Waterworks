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

class CheckThisBro extends WritePageEvent {
  String getCondiotionRadio;
  CheckThisBro({required this.getCondiotionRadio});
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

class WatchInvoiceUnitDone extends WritePageEvent {
  String id;
  var context;

  WatchInvoiceUnitDone({
    required this.id,
    required this.context,
  });
}

class ClearRadioDefault extends WritePageEvent {}

class EnabledButton extends WritePageEvent {
  bool getButt;

  EnabledButton({required this.getButt});
}


class CountForReset extends WritePageEvent {
  var context;
  CountForReset({this.context});
}