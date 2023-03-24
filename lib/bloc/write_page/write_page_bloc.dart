import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/screens/main%20screens/write_page.dart';

import '../../ETC/api_domain_url.dart';
import '../checkbox_newround/checkbox_bloc.dart';
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
            'water_meter_record_id': state.writeRecordId,
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
          print(response.data);
          event.context.read<NotWriteBloc>().add(Reload_Undone());
          event.context.read<DoneBloc>().add(Reload_Done());
          event.context.read<CheckboxBloc>().add(ClearCheck());
          event.context.read<RadioCheckBloc>().add(ClearRadioDefault());
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
