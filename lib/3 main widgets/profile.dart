import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/First_Page_bottomBar.dart';
import 'package:waterworks/login.dart';

import '../API/get_profile.dart';
import '../ETC/progressHUD.dart';
import '../main.dart';

String theTokenOne = '';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool circleHUD = false;
  @override
  void initState() {
    getToken();

    super.initState();
    ;
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
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '08',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 83, 83, 83)),
                                      ),
                                      Text(
                                        'เขตงานที่รับผิดชอบ',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 83, 83, 83)),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 8,
                                    ),
                                    child: Container(
                                      height: 50,
                                      width: 2,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '1,2,4',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 83, 83, 83)),
                                      ),
                                      Text(
                                        'ตอนงานที่รับผิดชอบ',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 83, 83, 83)),
                                      ),
                                    ],
                                  ),
                                ],
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
                          backgroundImage: AssetImage('assets/images/person.png'),
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

  Future getToken() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    var getThatToken = prefs2.get('keyToken');

    setState(() {
      theTokenOne = getThatToken.toString();
    });
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
