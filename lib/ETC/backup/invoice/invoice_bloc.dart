import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'package:waterworks/models/invoice_load_model.dart';
part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final dio = Dio();
  InvoiceBloc() : super(InvoiceState(invoice_data: '', loading: true, whatPage: '')) {
    
    on<Load_Invoice>((event, emit) async {
      print('Load_Incoive');
      emit(state.copyWith(loading: true, whatPage: event.whatPage));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('keyToken');
      try {
        final response = await dio.get(
          waterWork_domain + "record/invoice/" + event.id,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }),
        );
        dynamic dataInvoice = (state.invoice_data != '') ? state.invoice_data : '';
        dynamic nestedData = response.data['data'];
        if (response.statusCode == 200) {
          emit(state.copyWith(loading: false));
          dataInvoice = Invoice_Load_Data(
            id: await nestedData['id'],
            customerName: await nestedData['customer_name'],
            customerAddress: await nestedData['customer_address'],
            invoiceNumber: await nestedData['invoice_number'],
            areaNumber: await nestedData['area_number'],
            write_date: await nestedData['issue_date_format'],
            sumService: await nestedData['sum_service'],
            vat: await nestedData['vat'],
            bank: await nestedData['crossbank_number'],
            debt_months: nestedData['count_invoices'],
            sum_debt: await nestedData['sum_invoice'],
            godTotal: await nestedData['sum_total'],
            issue_month: await nestedData['due_date_format'],
            prapa_cost: await nestedData['sum'],
            total: await nestedData['total'],
            waterMeterRecord_current_unit: await nestedData['water_meter_record']['current_unit'],
            waterMeterRecord_previous_unit: await nestedData['water_meter_record']['previous_unit'],
            waterMeterRecord_record_date_format: await nestedData['water_meter_record']['record_date_format'],
            waterMeterRecord_sum_unit: await nestedData['water_meter_record']['sum_unit'],
            waterMeterRecord_waterNumber: nestedData['water_meter_record']['water_number'],
            waterMeterRecord_waterWrong: await (nestedData['water_meter_record']['water_wrong'].toString() == "1") ? false : true,
          );

          emit(state.copyWith(invoice_data: dataInvoice));
          // Navigator.push(
          //   event.context,
          //   PageTransition(
          //       duration: const Duration(milliseconds: 100),
          //       type: PageTransitionType.rightToLeft,
          //       child: Invoice_Page2()),
          // );
        } else {
          print('-----------fail api');
          print(response);
          emit(state.copyWith(loading: false));
        }
      } catch (e) {
        emit(state.copyWith(loading: false));
        print('----------- fail try');

        print("Exception $e");
      }
    });
  }
}
