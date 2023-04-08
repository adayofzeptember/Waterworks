import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/screens/write_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../ETC/api_domain_url.dart';
import '../../models/invoice_load_model.dart';
import '../../screens/First_Page_bottomBar.dart';
import '../../screens/invoice_page.dart';
part 'write_page_event.dart';
part 'write_page_state.dart';

class WritePageBloc extends Bloc<WritePageEvent, WritePageState> {
  WritePageBloc()
      : super(WritePageState(
            countForReset: 0,
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
            writeCondition: 'ปกติ',
            buttonEnable: true)) {

    on<EnabledButton>(
      (event, emit) {
        emit(state.copyWith(buttonEnable: event.getButt));

      },
    );
    on<ToPageWrite>((event, emit) async {
      print('ToPageWrite');
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
      emit(state.copyWith(writeRecordId: event.id, loading: true));
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
              loading: false,
            ),
          );
        } else {
          print('fail');
        }
      } on Exception catch (e) {
        print("Exception $e");
      }
    });

    on<CheckThisBro>((event, emit) {
      emit(state.copyWith(writeCondition: event.getCondiotionRadio));
    });

    on<CheckCurrentUnit>((event, emit) async {
      emit(state.copyWith(
          checkCurrentUnit: (event.currentUnit != '') ? false : true));
    });
    on<ClearRadioDefault>(
      (event, emit) {
        emit(state.copyWith(writeCondition: 'ปกติ'));
      },
    );

    on<ConfirmWriteUnit>((event, emit) async {
               emit(state.copyWith(buttonEnable: false));
      EasyLoading.show(
          status: 'โปรดรอสักครู่...', maskType: EasyLoadingMaskType.black);

      // print('ConfirmWriteUnit');
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
          print("invoice id: $invoiceId");
          emit(state.copyWith(loading: true, whatPage: 'list_unit_notdone'));
          try {
            final responseInvoice = await dio.get(
              waterWork_domain + "record/invoice/" + invoiceId,
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              }),
            );
            dynamic dataInvoice = '';
            dynamic nestedData = responseInvoice.data['data'];

            if (responseInvoice.statusCode == 200) {
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
                duedate: await nestedData['due_date_format'],
                sum_debt: await nestedData['sum_invoice'],
                godTotal: await nestedData['sum_total'],
                prapa_cost: await nestedData['sum'],
                total: await nestedData['total'],
                waterMeterRecord_current_unit:
                    await nestedData['water_meter_record']['current_unit'],
                waterMeterRecord_previous_unit:
                    await nestedData['water_meter_record']['previous_unit'],
                waterMeterRecord_record_date_format:
                    await nestedData['water_meter_record']
                        ['record_date_format'],
                waterMeterRecord_sum_unit:
                    await nestedData['water_meter_record']['sum_unit'],
                waterMeterRecord_waterNumber: nestedData['water_meter_record']
                    ['water_number'],
                waterMeterRecord_waterWrong: (nestedData['water_meter_record']
                                ['water_wrong']
                            .toString() ==
                        "1")
                    ? false
                    : true,
              );

              emit(state.copyWith(
                  invoice_data: await dataInvoice,
                  countForReset: state.countForReset + 1,
                  writeCondition: 'ปกติ'));

              Navigator.pop(event.context);
              EasyLoading.dismiss();
              await Future.delayed(const Duration(microseconds: 500), () {
                Navigator.push(
                  event.context,
                  PageTransition(
                    duration: const Duration(milliseconds: 300),
                    type: PageTransitionType.rightToLeft,
                    child: const InvoicePage2(),
                  ),
                );
              });
                       emit(state.copyWith(buttonEnable: true));
            } else {
              EasyLoading.showError(response.statusMessage.toString());
              EasyLoading.dismiss();
              Navigator.pop(event.context);
              print('-----------fail api');
              print(response);
                       emit(state.copyWith(buttonEnable: true));
              emit(state.copyWith(loading: false));
            }
          } catch (e) {
            EasyLoading.showError(e.toString());
            EasyLoading.dismiss();
                   emit(state.copyWith(buttonEnable: true));
            Navigator.pop(event.context);
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

    on<CountForReset>((event, emit) async {
      print(state.whatPage);
      if (state.whatPage == 'list_unit_done') {
        Navigator.pop(event.context);
      } else {
        if (state.countForReset == 15) {
          Phoenix.rebirth(event.context);
        } else {
          await Navigator.pushReplacement(
            event.context,
            PageTransition(
              duration: const Duration(milliseconds: 250),
              type: PageTransitionType.rightToLeft,
              child: Menu_Page(),
            ),
          );
        }
      }
    });

    on<WatchInvoiceUnitDone>((event, emit) async {
      Navigator.push(
        event.context,
        PageTransition(
          duration: const Duration(milliseconds: 250),
          type: PageTransitionType.rightToLeft,
          child: const InvoicePage2(),
        ),
      );

      emit(state.copyWith(loading: true, whatPage: 'list_unit_done'));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('keyToken');

      try {
        final dio = Dio();
        final response = await dio.get(
          waterWork_domain + "record/invoice/" + event.id,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }),
        );
        dynamic dataInvoice =
            (state.invoice_data != '') ? state.invoice_data : '';
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
            prapa_cost: await nestedData['sum'],
            duedate: await nestedData['due_date_format'],
            total: await nestedData['total'],
            waterMeterRecord_current_unit:
                await nestedData['water_meter_record']['current_unit'],
            waterMeterRecord_previous_unit:
                await nestedData['water_meter_record']['previous_unit'],
            waterMeterRecord_record_date_format:
                await nestedData['water_meter_record']['record_date_format'],
            waterMeterRecord_sum_unit: await nestedData['water_meter_record']
                ['sum_unit'],
            waterMeterRecord_waterNumber: nestedData['water_meter_record']
                ['water_number'],
            waterMeterRecord_waterWrong: await (nestedData['water_meter_record']
                            ['water_wrong']
                        .toString() ==
                    "1")
                ? false
                : true,
          );

          emit(state.copyWith(
            invoice_data: dataInvoice,
          ));
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
