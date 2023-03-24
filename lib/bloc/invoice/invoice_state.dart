part of 'invoice_bloc.dart';

class InvoiceState extends Equatable {
  dynamic invoice_data;
  bool loading;
  String whatPage;
  InvoiceState(
      {required this.invoice_data,
      required this.loading,
      required this.whatPage});

  InvoiceState copyWith(
      {dynamic invoice_data, bool? loading, String? whatPage}) {
    return InvoiceState(
        invoice_data: invoice_data ?? this.invoice_data,
        loading: loading ?? this.loading,
        whatPage: whatPage ?? this.whatPage
        
        );
  }

  @override
  List<Object> get props => [invoice_data, loading, whatPage];
}
