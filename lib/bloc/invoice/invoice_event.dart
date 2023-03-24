part of 'invoice_bloc.dart';

abstract class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}


class Load_Invoice extends InvoiceEvent{
  String id;
  var context;
  String whatPage;

  Load_Invoice({required this.id, required this.context, required this.whatPage});
}