import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/version_string.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../main.dart';
import '../../offline/office_route.dart';
import '../../service/get_profile.dart';
import '../../ETC/progressHUD.dart';
import '../../offline/utils.dart';

String theTokenOne = '';
String count = '';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool circleHUD = false;

  late Future<Profile_Data> futureProfile;
  @override
  void initState() {
    //logoutgetToken();_removeToken();
    check();

    super.initState();
  }

  Future _fd() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    print('----------------------> ' + version);
    return version;
  }

  void check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      print('not connected');
      showMyDialog(
        context,
        () {
          Navigator.pop(context);
          loadingInternet();
          Future.delayed(const Duration(seconds: 3), () {
            checkInternet(context);
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ProgressHUD(
        child: _uiLogOut(context), inAsyncCall: circleHUD, opacity: 0.3);
  }

  Widget _uiLogOut(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Palette.thisGreen,
        title: const Text('ข้อมูลผู้จดหน่วยวัดน้ำ'),
        centerTitle: true,
      ),
      backgroundColor: Palette.thisGreen,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 80,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 1,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 115,
                              ),
                              Text(
                                state.name.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: const [
                                      Text(
                                        'ตอนงานที่รับผิดชอบ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 83, 83, 83)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 30,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.idSegs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        children: [
                                          Text(
                                            (state.idSegs[index] != -1)
                                                ? "${state.segs[index]} - "
                                                : '',
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                          Text(
                                            (state.idSegs[index] != -1 &&
                                                    index ==
                                                        (state.idSegs.length +
                                                            1))
                                                ? ", "
                                                : "",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 177, 165, 165)),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      side:
                                          const BorderSide(color: Colors.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onPressed: () {
                                    Navigator.push(context, pageOffice());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "ใช้งานแบบออฟไลน์",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      side: BorderSide(
                                          color: Colors.red.shade900),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onPressed: () async {
                                    
                                    final Uri url = Uri.parse(
                                        'https://www.dropbox.com/scl/fo/t15br3qm94f6gey3y8wjv/h?rlkey=g964qgru1rw38ifvakcdiwv4g&dl=0'
                                        //'https://drive.google.com/drive/folders/1XfDECxDHTFMolckRb5eq76yT8asc0SEO?usp=share_link'
                               
                                        );
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(
                                        url,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "อัปเดต",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red.shade900,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      side: const BorderSide(
                                          color: Palette.thisGreen),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      circleHUD = true;
                                    });
                                    logout_removeToken();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "ออกจากระบบ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Palette.thisGreen,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'เวอร์ชันโปรแกรม: ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      version_by.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 104, 104, 104),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '|  ' + version_date.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 104, 104, 104),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const 
                      CircleAvatar(
                        radius: 85,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              AssetImage('assets/images/person.png'),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future logout_removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('keyToken');
    prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Start_Page_Waterworks(),
      ),
    );
  }
}
