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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/progressHUD.dart';
import 'package:waterworks/bloc/profile/profile_bloc.dart';
import 'package:waterworks/service/post_login.dart';
import 'package:waterworks/ETC/api_domain_url.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:http/http.dart' as http;

import 'First_Page_bottomBar.dart';

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
  bool circleHUD = false;

  void initState() {
    circleHUD = false;
    _login_request = Login_Request();
    getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ProgressHUD(child: _uiSetUp(context), inAsyncCall: circleHUD, opacity: 0.3);
  }

  @override
  Widget _uiSetUp(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/background_green.png',
              width: MediaQuery.of(context).size.width * 1, height: MediaQuery.of(context).size.height * 1, fit: BoxFit.fill),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Image.asset('assets/images/badge.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: formKey_LogIn,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            //  initialValue: 'watermeter13',
                            textAlign: TextAlign.left,
                            autofocus: false,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            onSaved: (input) => userName = input.toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'โปรดกรอกชื่อบัญชี';
                              }
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'กรอกบัญชีผู้ใช้',
                              labelStyle: const TextStyle(fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 238, 238, 238),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            // initialValue: 'password',
                            obscureText: true,
                            textAlign: TextAlign.left,
                            autofocus: false,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            onSaved: (input) => passWord = input.toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'โปรดกรอกรหัสผ่าน';
                              }
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'กรอกรหัสผ่าน',
                              labelStyle: const TextStyle(fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 0),
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 238, 238, 238),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: const Color.fromARGB(255, 235, 88, 62),
                                  elevation: 0,
                                  // side: BorderSide(color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              onPressed: () {
                                setState(() {
                                  circleHUD = true;
                                });
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (formKey_LogIn.currentState!.validate()) {
                                  formKey_LogIn.currentState?.save();
                                }

                                _login_request.username = userName;
                                _login_request.password = passWord;
                                _login_request.device_name = deviceDetail.toString().toUpperCase();
                                print(jsonEncode(_login_request));
                                loginNormal(_login_request);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "เข้าสู่ระบบ",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                                  ),
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

  Future<void> loginNormal(Login_Request requestModel) async {
    String urlPost = waterWork_domain + 'login';

    var body_Login = json.encode(requestModel.toJson());
    final response = await http.post(
      Uri.parse(urlPost),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      body: body_Login,
    );
    //print(jsonDecode(response.body.toString()));
    var jsonRes = json.decode(response.body);
    if (response.statusCode == 400 || response.statusCode == 200) {
      setState(() {
        circleHUD = false;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('keyToken', jsonRes['data']['access_token'].toString());
      print(jsonRes['data']['access_token'].toString());
      context.read<ProfileBloc>().add(LoadProfile());
      Navigator.pushReplacement(context,
          PageTransition(duration: const Duration(milliseconds: 500), type: PageTransitionType.rightToLeft, child: Menu_Page()));
    } else {
      setState(() {
        circleHUD = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red[400],
        content: const Text(
          'บัญชีหรือรหัสผ่านไม่ถูกต้อง',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ));
      print('response.body');
    }
  }

  Future<void> getDeviceInfo() async {
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
      deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }

    setState(() {
      _deviceData = deviceData;

      deviceDetail = (deviceData['brand'] == null) ? "IPHONE" : deviceData['brand'] + '-' + deviceData['model'];
    });
    print(deviceDetail);
  }
}
