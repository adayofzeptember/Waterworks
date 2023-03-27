import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/screens/main%20screens/write_page.dart';

import '../../ETC/api_domain_url.dart';
import '../../models/invoice_load_model.dart';
import '../../screens/main screens/invoice_page3.dart';
import '../checkbox_newround/checkbox_bloc.dart';
import '../invoice/invoice_bloc.dart';
import '../load_done/done_bloc.dart';
import '../load_undone/undone_bloc.dart';
import '../radio_butts/radio_check_bloc.dart';

part 'write_page_event.dart';
part 'write_page_state.dart';

class WritePageBloc extends Bloc<WritePageEvent, WritePageState> {
  WritePageBloc()
      : super(WritePageState(
          writeRecordId: "",
          customerName: "",
          address: "",
          waterNumber: "",
          areaNumber: "",
          meterNumber: "",
          previousUnitFormat: "",
          invoices: Null,
          checkCurrentUnit: false,
          invoice_data: '',
          loading: true,
          whatPage: '',
        )) {
    on<ToPageWrite>((event, emit) async {
      Navigator.push(
        event.context,
        PageTransition(
          duration: const Duration(milliseconds: 250),
          type: PageTransitionType.rightToLeft,
          child: WritePage(),
        ),
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('keyToken');
      emit(state.copyWith(writeRecordId: event.id));
      try {
        final dio = Dio();
        final response = await dio.get(
          waterWork_domain + "water_meter_record/show/${event.id}",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Authorization": "Bearer $token",
          }),
        );

        if (response.data['responseStatus'].toString() == "true") {
          dynamic responseData = response.data['data'];
          emit(
            state.copyWith(
              customerName: responseData['customer_water']['name'],
              address: responseData['customer_water']['address'],
              waterNumber: responseData['customer_water']['water_number'],
              areaNumber: responseData['customer_water']['area_number'],
              meterNumber: responseData['customer_water']['meter_number'],
              previousUnitFormat: responseData['previous_unit_format'],
            ),
          );
        } else {
          print('fail');
        }
      } on Exception catch (e) {
        print("Exception $e");
      }
    });

    on<CheckCurrentUnit>((event, emit) async {
      emit(state.copyWith(checkCurrentUnit: (event.currentUnit != '') ? false : true));
    });

    on<ConfirmWriteUnit>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('keyToken');
      try {
        final dio = Dio();
        final response = await dio.post(
          waterWork_domain + "water_meter_record/update",
          data: {
            'water_meter_record_id': event.id,
            'current_unit': event.currentUnit,
            'new_round': event.statusMeter,
          },
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Authorization": "Bearer $token",
          }),
        );

        if (response.data['responseStatus'].toString() == "true") {
          String invoiceId = response.data['data']['invoice']['id'].toString();
          print("invouce = $invoiceId");
          try {
            print('fgggg');
            final responseInvoice = await dio.get(
              waterWork_domain + "record/invoice/" + invoiceId,
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              }),
            );
            dynamic dataInvoice = '';
            dynamic nestedData = responseInvoice.data['data'];
            print('111');
            if (responseInvoice.statusCode == 200) {
              print('112');

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
                prapa_cost: await nestedData['sum'],
                total: await nestedData['total'],
                waterMeterRecord_current_unit: await nestedData['water_meter_record']['current_unit'],
                waterMeterRecord_previous_unit: await nestedData['water_meter_record']['previous_unit'],
                waterMeterRecord_record_date_format: await nestedData['water_meter_record']['record_date_format'],
                waterMeterRecord_sum_unit: await nestedData['water_meter_record']['sum_unit'],
                waterMeterRecord_waterNumber: nestedData['water_meter_record']['water_number'],
                waterMeterRecord_waterWrong: await (nestedData['water_meter_record']['water_wrong'].toString() == "1") ? false : true,
              );
              print('113');

              emit(state.copyWith(invoice_data: dataInvoice));
              print('114');
              print(dataInvoice);
              Navigator.push(
                event.context,
                PageTransition(
                  duration: const Duration(milliseconds: 100),
                  type: PageTransitionType.rightToLeft,
                  child: InvoicePage2(),
                ),
              );
              emit(state.copyWith(loading: false));
              print('115');
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
        } else {
          print('fail');
        }
      } on Exception catch (e) {
        print("Exception $e");
      }
    });
  }
}

// Future<void> write_unit(WriteUnit_Request write_requestModel) async {
//   String urlPost = waterWork_domain + 'water_meter_record/update';

//   SharedPreferences prefs2 = await SharedPreferences.getInstance();
//   var getThatToken = prefs2.get('keyToken');

//   var body_unitWritten = json.encode(write_requestModel.toJson());
//   final response = await http.post(
//     Uri.parse(urlPost),
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $getThatToken',
//     },
//     body: body_unitWritten,
//   );

//   String jsonsDataString = response.body;
//   var datax = json.decode(jsonsDataString);

//   if (response.statusCode == 200 || response.statusCode == 400) {
//     setState(() {
//       circleHUD = false;
//     });
//     print('----------- write success, invoice id: ' + datax['data']['invoice']['id'].toString());
//     //! bloc funtion clear
//     context.read<NotWriteBloc>().add(Reload_Undone(context));
//     context.read<DoneBloc>().add(Reload_Done(context));
//     context.read<CheckboxBloc>().add(ClearCheck());
//     context.read<RadioCheckBloc>().add(ClearRadioDefault());

//     Navigator.push(
//       context,
//       PageTransition(
//           duration: const Duration(milliseconds: 100),
//           type: PageTransitionType.rightToLeft,
//           child: Invoice_Page(
//             invoiceID: datax['data']['invoice']['id'].toString(),
//           )),
//     );
//   } else {
//     setState(() {
//       circleHUD = false;
//     });
//     print('----------- write water failed -----------');
//     print(response.body);
//   }
// }
