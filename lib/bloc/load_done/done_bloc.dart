import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import '../../../models/Load_Done.dart';
part 'done_event.dart';
part 'done_state.dart';

class DoneBloc extends Bloc<DoneEvent, DoneState> {
  final dio = Dio();
  DoneBloc()
      : super(DoneState(
          written: [],
          page: 1,
          isLoading: true,
          error: '',
          segmentActive: 0,
          filterId: '-1',
          dataTotal: 0,
        )) {
    on<Load_DoneData>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('keyToken');
      String? sagmentId = (state.filterId != '-1') ? "&water_meter_segmentation_id=${state.filterId}" : "";

      try {
        final response = await dio.get(
          waterWork_domain + "water_meter_record/index?per_page=8&status=processing&page=${state.page}$sagmentId",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }),
        );
        var dataAllDone = (state.written != []) ? state.written : [];
        if (response.data['responseStatus'].toString() == "true") {
          emit(state.copyWith(dataTotal: response.data['data']['total']));
          if (response.data['data']['total'] != dataAllDone.length) {
            print("if" + response.data['data']['total'].toString());
            for (var el in response.data['data']['data']) {
              dataAllDone.add(
                Done_Model(
                  id: await el['id'],
                  customerName: await el['customer_water']['name'],
                  waterNumber: await el['water_number'],
                  areaNumber: await el['area_number'],
                  customerAddress: await el['customer_water']['address'],
                  meterNumber: (el['customer_water']['meter_number'] != "") ? await el['customer_water']['meter_number'] : "0",

                  invoiceID: await el['invoice']['id'],
                  // status: await (el['customer_water']['status'] == "Normal") ? true : false
                ),
              );
            }
            emit(state.copyWith(
              written: dataAllDone,
              page: state.page + 1,
              isLoading: (dataAllDone.length == response.data['data']['total']) ? false : true,
            ));
          } else {
            print("total data = " + response.data['data']['total'].toString());
            print('current data = ' + dataAllDone.length.toString());
            emit(state.copyWith(
              error: dataAllDone.length == 0 ? 'not' : '',
              isLoading: false,
            ));
          }
        } else {
          emit(state.copyWith(error: 'Loading Fail'));
          print('fail');
        }
      } catch (e) {
        print("Exception $e");
      }
    });
    on<Reload_Done>(((event, emit) {
      emit(state.copyWith(written: [], page: 1));
    }));
    on<FilterData>((event, emit) async {
      emit(state.copyWith(
        written: [],
        page: 1,
        segmentActive: event.segmentActive,
        filterId: event.id,
      ));
      add(Load_DoneData());
    });
  }
}
