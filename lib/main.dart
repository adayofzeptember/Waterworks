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
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/First_Page_bottomBar.dart';
import 'package:waterworks/login.dart';
import '3._print_bluetooth_thermal[cool].dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(Start_Page_Waterworks()));
}

class Start_Page_Waterworks extends StatelessWidget {
  const Start_Page_Waterworks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('th', 'TH'),
      ],
      theme: ThemeData(
        primarySwatch: Palette.thisGreen,
        fontFamily: 'Kanit',
      ),
      home: Load_Page(),
    );
  }
}

class Load_Page extends StatefulWidget {
  const Load_Page({Key? key}) : super(key: key);

  @override
  State<Load_Page> createState() => _Load_PageState();
}

class _Load_PageState extends State<Load_Page> {
  @override
  initState() {
    grantBlue();
    _Load_And_Go();
    super.initState();
  }

  Future<void> grantBlue() async {
    var statusLocation = Permission.location;
    if (await statusLocation.isGranted != true) {
      await Permission.location.request();
      await Permission.bluetooth.request();
      await Permission.nearbyWifiDevices.request();
      await Permission.bluetoothScan.request();
      await Permission.bluetoothAdvertise.request();
      await Permission.bluetoothConnect.request();
    }
  }

  Future _Load_And_Go() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    var getThatToken = prefs2.get('keyToken');

    if (getThatToken.toString() == 'null') {
      await Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          PageTransition(
              duration: Duration(milliseconds: 820),
              type: PageTransitionType.bottomToTop,
              child: Login()),
        );
      });
    } else {
      await Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          PageTransition(
              duration: Duration(milliseconds: 820),
              type: PageTransitionType.bottomToTop,
              child: Menu_Page()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
        body: Stack(
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
                  'การประปาเทศบาลนคร',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'นครราชสีมา',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    ));
  }
}



// Widget x() {
//   return Container(
//     child: Text('1'),
//   );
// }
// Widget y() {
//   return Container(
//     child: Text('2'),
//   );
// }



