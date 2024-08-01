import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/models/Load_NotDone.dart';
import '../../ETC/api_domain_url.dart';
part 'undone_event.dart';
part 'undone_state.dart';

class NotWriteBloc extends Bloc<NotWriteEvent, NotWriteState> {
  NotWriteBloc()
      : super(NotWriteState(
          notWrite: [],
          page: 1,
          isLoading: true,
          error: '',
          segmentActive: 0,
          filterId: '-1',
          hiddenMeter: '',
          dataTotal: 0,
        )) {
    on<Load_unDoneData>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('keyToken');
      emit(state.copyWith(
        hiddenMeter: (prefs.getString('hiddenMater') != null) ? prefs.getString('hiddenMater') : '0',
        isLoading: true,
        error: '',
      ));
      String? hiddenMeter =
          (state.hiddenMeter != '' && state.hiddenMeter != '0') ? "&customer_water_status=${state.hiddenMeter}" : "";
      String? sagmentId = (state.filterId != '-1') ? "&water_meter_segmentation_id=${state.filterId}" : "";
      try {
        final dio = Dio();
        final response = await dio.get(
          waterWork_domain + "water_meter_record/index?per_page=8&status=pending&page=${state.page}$hiddenMeter$sagmentId",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }),
        );
        var dataAllStore = (state.notWrite != []) ? state.notWrite : [];
        if (response.data['responseStatus'].toString() == "true") {
          emit(state.copyWith(dataTotal: response.data['data']['total']));
          if (response.data['data']['total'] != dataAllStore.length) {
            // print("if" + response.data['data']['total'].toString());
            for (var el in response.data['data']['data']) {
              dataAllStore.add(
                NotWrite_Model(
                    id: await el['id'],
                    customerName: await el['customer_water']['name'] ?? '',
                    waterNumber: await el['water_number'] ?? '',
                    areaNumber: await el['area_number'] ?? '',
                    customerAddress: await el['customer_water']['address'] ?? '',
                    meterNumber: await (el['customer_water']['meter_number'] != "") ? await el['customer_water']['meter_number'] : "-",
                    status: (el['customer_water']['status'] == "Normal") ? true : false),
              );
            }

            emit(state.copyWith(
              notWrite: dataAllStore,
              page: state.page + 1,
              isLoading: (dataAllStore.length == response.data['data']['total']) ? false : true,
              error: dataAllStore.length == 0 ? 'not' : '',
            ));
          } else {
            print("total data = " + response.data['data']['total'].toString());
            print('current data = ' + dataAllStore.length.toString());
            emit(state.copyWith(
              error: dataAllStore.length == 0 ? 'not' : '',
              isLoading: false,
            ));
          }
        } else {
          print('fail');
          emit(state.copyWith(error: 'Fail'));
        }
      } on Exception catch (e) {
        print("Exception $e");
        emit(state.copyWith(error: e.toString()));
      }
    });
    on<Reload_Undone>((event, emit) {
      emit(state.copyWith(notWrite: [], page: 1));
    });
    on<FilterData>((event, emit) async {
      emit(state.copyWith(
        notWrite: [],
        page: 1,
        segmentActive: event.segmentActive,
        filterId: event.id,
      ));
      add(Load_unDoneData());
    });

    on<BackMenu>((event, emit) async {
      add(FilterData(
        id: state.filterId,
        segmentActive: state.segmentActive,
      ));
    });
  }
}
