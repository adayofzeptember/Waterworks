import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/First_Page_bottomBar.dart';
import 'package:waterworks/login.dart';
import 'package:http/http.dart' as http;
import '../API/get_profile.dart';
import '../ETC/progressHUD.dart';
import '../main.dart';
import '../offline/office_route.dart';
import '../offline/utils.dart';

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
    _getToken();
    check();

    // fetchProfile_Authx(theTokenOne);
    super.initState();
    ;
  }

  void check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _getToken();
      }
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
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ProgressHUD(
        child: _uiLogOut(context), inAsyncCall: circleHUD, opacity: 0.3);
  }

  @override
  Widget _uiLogOut(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Palette.thisGreen,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text('ข้อมูลผู้จดหน่วยวัดน้ำ'),
            Text(''),
          ],
        ),
      ),
      backgroundColor: Palette.thisGreen,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            FutureBuilder<Profile_Data>(
              future: fetchProfile_Auth(theTokenOne),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Profile_Data? data = snapshot.data; 
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
                              SizedBox(
                                height: 115,
                              ),
                              Text(
                                data!.name.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
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
                              Container(
                                height: 20,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.segmentations?.length,
                                    itemBuilder:
                                        (BuildContext context, int indexEP) {
                                      return Row(
                                        children: [
                                          Text(
                                            data.segmentations![indexEP].name
                                                    .toString() +
                                                " | ",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      elevation: 0,
                                      side: BorderSide(color: Colors.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onPressed: () {
                                    Navigator.push(context, pageOffice());
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Text(
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
                                      primary: Colors.white,
                                      elevation: 0,
                                      side:
                                          BorderSide(color: Palette.thisGreen),
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
                                    padding: EdgeInsets.all(15.0),
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Text(
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
                            ],
                          ),
                        ),
                      ),
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
                }

                return Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _getToken() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    var getThatToken = prefs2.get('keyToken');

    setState(() {
      theTokenOne = getThatToken.toString();
    });

    print(theTokenOne);
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
