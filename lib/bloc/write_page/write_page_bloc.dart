import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/screens/write_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../ETC/api_domain_url.dart';
import 'model.dart';
import '../../screens/main screens/bottombar_page.dart';
import '../../screens/invoice_page.dart';
part 'write_page_event.dart';
part 'write_page_state.dart';

class WritePageBloc extends Bloc<WritePageEvent, WritePageState> {
  WritePageBloc()
      : super(WritePageState(
            lat: '0',
            lng: '0',
            bill_data: '',
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
      EasyLoading.show(
          status: 'กำลังเข้าถึงตำแหน่งปัจจุบัน...',
          maskType: EasyLoadingMaskType.black);
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position.latitude.toString() + position.longitude.toString());
      EasyLoading.dismiss();
      emit(state.copyWith(
          lat: position.latitude.toString(),
          lng: position.longitude.toString()));
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
              child: Bottom_bar_page(),
            ),
          );
        }
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

      final dio = Dio();
      final response = await dio.post(
        waterWork_domain + "water_meter_record/update",
        data: {
          'water_meter_record_id': event.id,
          'current_unit': event.currentUnit,
          'new_round': event.statusMeter,
          'lat': event.getLng,
          'lng': event.getLng,
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
          dynamic dataBill = '';

          dynamic nestedData = responseInvoice.data['data'];
          List<FiveMonths_Back> fiveMonthsBackList = [];
          List<DebtMonths_Step> debtmonthsList = [];

          if (responseInvoice.statusCode == 200) {
            emit(state.copyWith(loading: false));
            for (var item in nestedData['history_meters']) {
              fiveMonthsBackList.add(FiveMonths_Back(
                month: await item['month'].toString(),
                sum_unit: await item['sum_unit'].toString(),
              ));
            }
            for (var item in nestedData['months_step']) {
              debtmonthsList.add(DebtMonths_Step(
                name: await item['name'].toString(),
                total: await item['total'].toString(),
              ));
            }
            dataInvoice = Invoice_Load_Data(
              id: await nestedData['id'],
              customerName: await nestedData['customer_name'],
              dueDate: await nestedData['due_date_format'],
              customerAddress: await nestedData['customer_address'],
              invoiceStatus: await nestedData['status'],
              invoiceNumber: await nestedData['invoice_number'],
              areaNumber: await nestedData['area_number'],

              water_meter_record_nowUnit:
                  await nestedData['water_meter_record_now_unit'],
              water_meter_record_nowMonth:
                  await nestedData['water_meter_record_now_month'],
              water_meter_record_beforeMonth:
                  await nestedData['water_meter_record_before_month'],
              water_meter_record_beforeUnit:
                  await nestedData['water_meter_record_before_unit'],
              sum_months: await nestedData['sum_months'] ?? ' ',
              sum_invoice: await nestedData['sum_invoice'],
              write_date: await nestedData['issue_date_format'],
              sumService: await nestedData['sum_service_format'],
              vat: await nestedData['vat_format'],
              bank: await nestedData['crossbank_number'], //! qr
              debt_months: nestedData['count_invoices'],
              sum_debt: await nestedData['sum_invoice'],
              bank_barcode: await nestedData['crossbank_number_barcode'],
              prapa_cost: await nestedData['sum_format'],
              issue_month: await nestedData['issue_date_month_format'],
              total: await nestedData['total_format'],
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
              meter_status: await nestedData['meter_status'],
              meter_status_text: await nestedData['meter_status_text'],
              //*new
              total_format: await nestedData['total_format'],
              meter_number: await nestedData['customer_water']['meter_number'],
              sum_total: await nestedData['sum_total'],

              meter_name: await nestedData['customer_water']['water_meter_fee']
                  ['name'],
              fiveMonths_Back_Model: fiveMonthsBackList,
              debt_months_step: debtmonthsList,
              sum_total_text: await nestedData['sum_total_text'],
              tax: await nestedData['customer_water']['tax_number'],

              information_discountText: await nestedData['information_data']
                  ['invoice_has_discount'],
              information_waterWrong: await nestedData['information_data']
                  ['invoice_meter_wrong'],
              information_textDuedate: await nestedData['information_data']
                  ['invoice_text_duedate'],
              information_textOverdue: await nestedData['information_data']
                  ['invoice_text_overdue'],

              paymentAutoCheck: await nestedData['customer_water']
                      ['bank_payment_auto']
                  .toString(),
              information_textAlert: await nestedData['information_data']
                  ['invoice_text_alert'],
              information_textdebitbank: await nestedData['information_data']
                  ['invoice_text_debit_bank'],
            );

            dataBill = Bill_Load_Data(
              bill_id: await nestedData['bill']['id'],
              bill_number: await nestedData['bill']['bill_number'],
              bill_customerName: await nestedData['bill']['customer_name'],
              bill_customerAddress: await nestedData['bill']
                  ['customer_address'],
              bill_taxNumber: await nestedData['customer_water']['tax_number'],
              bill_areaNumber: await nestedData['bill']['area_number'],
              bill_waterNumber: await nestedData['bill']['water_number'],
              bill_Month: await nestedData['bill']['invoice_date_month_format'],
              bill_meterNumber: await nestedData['customer_water']
                  ['meter_number'],
              bill_size: await nestedData['customer_water']['water_meter_fee']
                  ['name'],
              bill_invoiceNumber: await nestedData['bill']['record_invoice']
                  ['invoice_number'],
              bill_previousNumber: await nestedData['bill']['record_invoice']
                  ['water_meter_record']['previous_unit'],
              bill_nowNumber: await nestedData['bill']['record_invoice']
                  ['water_meter_record']['current_unit'],
              bill_sumUnit: await nestedData['bill']['record_invoice']
                  ['water_meter_record']['sum_unit'],
              bill_sumFormat: await nestedData['bill']['sum_format'],
              bill_sumService: await nestedData['bill']['sum_service_format'],
              bill_discount: await nestedData['bill']['discount_format'],
              bill_vat: await nestedData['bill']['vat_format'],
              bill_totalFormat: await nestedData['bill']['total_format'],
              bill_totalFormat_text: await nestedData['bill']
                  ['total_format_text'],
              fiveMonths_Back_Model: fiveMonthsBackList,
              //*
              bill_zpl: await nestedData['bill']['bill_license_zpl'].toString(),
              bill_paymentType: await nestedData['bill']
                      ['payment_type_description']
                  .toString(),
              bill_recieveName:
                  await nestedData['bill']['user_receive_name'].toString(),
              bill_recievePosition:
                  await nestedData['bill']['user_position'].toString(),
              bill_issue_dateFormat:
                  await nestedData['bill']['issue_date_format'].toString(),
            );

            emit(state.copyWith(
                invoice_data: await dataInvoice,
                bill_data: await dataBill,
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
    });

//*--------------------------------------- ดูบิล --------------------------------------------------
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
        dynamic dataBill;
        dynamic nestedData = response.data['data'];
        List<FiveMonths_Back> fiveMonthsBackList = [];
        List<DebtMonths_Step> debtmonthsList = [];

        if (response.statusCode == 200) {
          emit(state.copyWith(loading: false));

          for (var item in nestedData['history_meters']) {
            fiveMonthsBackList.add(FiveMonths_Back(
              month: await item['month'].toString(),
              sum_unit: await item['sum_unit'].toString(),
            ));
          }
          for (var item in nestedData['months_step']) {
            debtmonthsList.add(DebtMonths_Step(
              name: await item['name'].toString(),
              total: await item['total'].toString(),
            ));
          }
          dataInvoice = Invoice_Load_Data(
            id: await nestedData['id'],
            customerName: await nestedData['customer_name'],
            customerAddress: await nestedData['customer_address'],
            invoiceNumber: await nestedData['invoice_number'],
            areaNumber: await nestedData['area_number'],
            invoiceStatus: await nestedData['status'],
            water_meter_record_nowUnit:
                await nestedData['water_meter_record_now_unit'],
            water_meter_record_nowMonth:
                await nestedData['water_meter_record_now_month'],
            water_meter_record_beforeMonth:
                await nestedData['water_meter_record_before_month'],
            water_meter_record_beforeUnit:
                await nestedData['water_meter_record_before_unit'],
            sum_months: await nestedData['sum_months'],
            sum_invoice: await nestedData['sum_invoice'],
            write_date: await nestedData['issue_date_format'],
            sumService: await nestedData['sum_service_format'],
            dueDate: await nestedData['due_date_format'],
            vat: await nestedData['vat_format'],
            bank: await nestedData['crossbank_number'],
            bank_barcode: await nestedData['crossbank_number_barcode'],
            debt_months: nestedData['count_invoices'],
            sum_debt: await nestedData['sum_invoice'],
            prapa_cost: await nestedData['sum_format'],
            issue_month: await nestedData['issue_date_month_format'],
            total: await nestedData['total_format'],
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
            meter_status: await nestedData['meter_status'],
            meter_status_text: await nestedData['meter_status_text'],
            //*new
            total_format: await nestedData['total_format'],
            tax: await nestedData['customer_water']['tax_number'],
            meter_number: await nestedData['customer_water']['meter_number'],
            sum_total: await nestedData['sum_total'],
            meter_name: await nestedData['customer_water']['water_meter_fee']
                ['name'],
            fiveMonths_Back_Model: fiveMonthsBackList,
            debt_months_step: debtmonthsList,
            sum_total_text: await nestedData['sum_total_text'],
            information_discountText: await nestedData['information_data']
                ['invoice_has_discount'],
            information_waterWrong: await nestedData['information_data']
                ['invoice_meter_wrong'],
            information_textDuedate: await nestedData['information_data']
                ['invoice_text_duedate'],
            information_textOverdue: await nestedData['information_data']
                ['invoice_text_overdue'],

            paymentAutoCheck: await nestedData['customer_water']
                    ['bank_payment_auto']
                .toString(),
            information_textAlert: await nestedData['information_data']
                ['invoice_text_alert'],
            information_textdebitbank: await nestedData['information_data']
                ['invoice_text_debit_bank'],
          );

          dataBill = Bill_Load_Data(
            bill_id: await nestedData['bill']['id'].toString(),
            bill_number: await nestedData['bill']['bill_number'].toString(),
            bill_customerName:
                await nestedData['bill']['customer_name'].toString(),
            bill_customerAddress:
                await nestedData['bill']['customer_address'].toString(),
            bill_taxNumber:
                await nestedData['customer_water']['tax_number'].toString(),
            bill_areaNumber: await nestedData['bill']['area_number'].toString(),
            bill_waterNumber:
                await nestedData['bill']['water_number'].toString(),
            bill_Month: await nestedData['bill']['invoice_date_month_format']
                .toString(),
            bill_meterNumber:
                await nestedData['customer_water']['meter_number'].toString(),
            bill_size: await nestedData['customer_water']['water_meter_fee']
                    ['name']
                .toString(),
            bill_invoiceNumber: await nestedData['bill']['record_invoice']
                    ['invoice_number']
                .toString(),
            bill_previousNumber: await nestedData['bill']['record_invoice']
                    ['water_meter_record']['previous_unit']
                .toString(),
            bill_nowNumber: await nestedData['bill']['record_invoice']
                    ['water_meter_record']['current_unit']
                .toString(),
            bill_sumUnit: await nestedData['bill']['record_invoice']
                    ['water_meter_record']['sum_unit']
                .toString(),
            bill_sumFormat: await nestedData['bill']['sum_format'].toString(),
            bill_sumService:
                await nestedData['bill']['sum_service_format'].toString(),
            bill_discount:
                await nestedData['bill']['discount_format'].toString(),
            bill_vat: await nestedData['bill']['vat_format'].toString(),
            bill_totalFormat:
                await nestedData['bill']['total_format'].toString(),
            bill_totalFormat_text:
                await nestedData['bill']['total_format_text'].toString(),
            fiveMonths_Back_Model: fiveMonthsBackList,
            //
            bill_zpl: await nestedData['bill']['bill_license_zpl'].toString(),
            bill_paymentType:
                await nestedData['bill']['payment_type_description'].toString(),
            bill_recieveName:
                await nestedData['bill']['user_receive_name'].toString(),
            bill_recievePosition:
                await nestedData['bill']['user_position'].toString(),
            bill_issue_dateFormat:
                await nestedData['bill']['issue_date_format'].toString(),
          );

          emit(state.copyWith(invoice_data: dataInvoice, bill_data: dataBill));
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
