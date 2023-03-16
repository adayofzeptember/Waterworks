import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import '../../../models/Load_NotDone.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(SearchState(
            searchResult: [], isLoading: true, statusSearch: '', error: '')) {
    on<SearchNumber>((event, emit) async {
      if (event.searchNumber == "") {
        emit(state.copyWith(statusSearch: "1"));
      } else {
        //! status 0 ระหว่างรอมันโหลด
        emit(state.copyWith(statusSearch: "0"));

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('keyToken');
        try {
          final dio = Dio();
          final response = await dio.get(
            waterWork_domain +
                'water_meter_record/index?per_page=10&status=pending&search=${event.searchNumber}',
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            }),
          );
          var dataSearchRes = [];
          if (response.statusCode == 400 || response.statusCode == 200) {
            if (response.data['data']['data'].length == 0) {
               //! พอโหลดเสร็จจะไม่ใช่เลข 0 แล้ว
              emit(state.copyWith(statusSearch: 'ไม่พบข้อมูล'));
            } else {
              emit(state.copyWith(statusSearch: ''));
            }
            for (var el in response.data['data']['data']) {
              dataSearchRes.add(
                NotWrite_Model(
                    id: await el['id'],
                    customerName: await el['customer_water']['name'],
                    waterNumber: await el['water_number'],
                    areaNumber: await el['area_number'],
                    customerAddress: await el['customer_water']['address'],
                    meterNumber: (el['customer_water']['meter_number'] != "")
                        ? await el['customer_water']['meter_number']
                        : "0",
                    status: await (el['customer_water']['status'] == "Normal")
                        ? true
                        : false),
              );
            }

            emit(state.copyWith(searchResult: dataSearchRes));
            // print(state.searchResult.length);
          } else {
            print('fail');
          }
        } on Exception catch (e) {
          print("Exception $e");
          emit(state.copyWith(statusSearch: "2", error: e.toString()));
        }
      }
    });

    on<ClearSearch>((event, emit) {
      emit(state.copyWith(searchResult: []));
    });
  }
}
