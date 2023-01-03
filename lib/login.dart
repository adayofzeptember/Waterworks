import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/API/post_login.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/testers/testprint_bluetooth_print.dart';
import 'package:http/http.dart' as http;

String deviceDetail = '';
String storedToken = '';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  late Login_Request _login_request;
  var deviceData = <String, dynamic>{};
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final formKey_LogIn = GlobalKey<FormState>();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  String userName = '';
  String passWord = '';

  void initState() {
    _login_request = Login_Request();
    initPlatformState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/background_green.png',
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1,
              fit: BoxFit.fill),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Image.asset('assets/images/badge.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: formKey_LogIn,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            textAlign: TextAlign.left,
                            autofocus: false,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            onSaved: (input) => userName = input.toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'โปรดกรอกชื่อบัญชี';
                              }
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'กรอกบัญชีผู้ใช้',
                              labelStyle: TextStyle(fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 238, 238),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            textAlign: TextAlign.left,
                            autofocus: false,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            onSaved: (input) => passWord = input.toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'โปรดกรอกรหัสผ่าน';
                              }
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'กรอกรหัสผ่าน',
                              labelStyle: TextStyle(fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 238, 238),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Palette.thisGreen,
                                elevation: 0,
                                // side: BorderSide(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (formKey_LogIn.currentState!.validate()) {
                                formKey_LogIn.currentState?.save();
                              }
                              print(userName + passWord);
                              _login_request.username = 'watermeter1';
                              _login_request.password = 'password';
                              _login_request.device_name =
                                  deviceDetail.toString();
                              print(jsonEncode(_login_request));
                              _loginNormal(_login_request);

                              // Navigator.pushReplacement(
                              //   context,
                              //   PageTransition( 
                              //       duration: Duration(milliseconds: 500),
                              //       type: PageTransitionType.rightToLeft,
                              //       //child: Menu_Page(),
                              //       child: Login()),
                              // );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "เข้าสู่ระบบ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
      return <String, dynamic>{
        'brand': build.brand,
        'model': build.model,
      };
    }

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    setState(() {
      _deviceData = deviceData;
      deviceDetail = deviceData['brand'] + '-'+deviceData['model'];
    });
    print(deviceDetail);
  }

  Future<void> _loginNormal(Login_Request requestModel) async {
    String urlPost = waterWork_domain + 'login';

    var body_Login = json.encode(requestModel.toJson());
    final response = await http.post(
      Uri.parse(urlPost),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: body_Login,
    );

    var jsonRes = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(response.body);
      print(jsonRes['data']['access_token']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('keyToken', jsonRes['data']['access_token'].toString());
    } else {
      print(response.body);
    }
  }
}
