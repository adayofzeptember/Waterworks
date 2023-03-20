import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/service/get_profile.dart';

import '../../ETC/api_domain_url.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(ProfileState(
          name: "",
          segs: [],
          idSegs: [],
        )) {
    on<LoadProfile>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dio = Dio();
      String? token = prefs.getString('keyToken');
      try {
        final response = await dio.get(
          waterWork_domain + "me",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }),
        );
        var dataSegment = [], id = [];
        if (response.data['responseStatus'].toString() == "true") {
          id.add(-1);
          dataSegment.add('ทั้งหมด');
          for (var el in response.data['data']['segmentations']) {
            id.add(el['id']);
            dataSegment.add(el['name']);
          }
          emit(state.copyWith(name: response.data['data']['name'], segs: dataSegment, idSegs: id));
        } else {
          print('fail');
        }
      } catch (e) {
        print("Exception $e");
      }
    });
  }
}
