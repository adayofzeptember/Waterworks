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
        )) {
    
    on<Load_unDoneData >((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('keyToken');
      try {
        final dio = Dio();
        final response = await dio.get(
          waterWork_domain+"water_meter_record/index?per_page=8&status=pending&page=${state.page}",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }),
        );
        var dataAllStore = (state.notWrite != []) ? state.notWrite : [];
        if (response.data['responseStatus'].toString() == "true") {
          for (var el in response.data['data']['data']) {
            dataAllStore.add(
              NotWrite_Model (
                id: await el['id'],
                customerName: await el['customer_water']['name'],
                waterNumber: await el['water_number'],
                areaNumber: await el['area_number'],
                customerAddress: await el['customer_water']['address'],
                meterNumber: (el['customer_water']['meter_number'] != "") ? await el['customer_water']['meter_number'] : "0",
                status: await (el['customer_water']['status'] == "Normal") ? true : false
              ),
            );
          }

          emit(state.copyWith(notWrite: dataAllStore));
          emit(state.copyWith(page: state.page + 1));
          emit(state.copyWith(isLoading: (dataAllStore.length == response.data['data']['total']) ? false : true));
          
        } else {
          print('fail');
        }
      } on Exception catch (e) {
        print("Exception $e");
      }
    });
  }
}
