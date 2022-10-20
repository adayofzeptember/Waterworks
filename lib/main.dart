import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waterworks/ETC/color_green.dart'                                                                                                                                             ;
import 'package:waterworks/Main_menu_page.dart';
import 'package:waterworks/test.dart';

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
    _Load_And_Go();
    super.initState();
  }

  Future _Load_And_Go() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          duration: Duration(seconds: 1),
          type: PageTransitionType.rightToLeft,
          child: Menu_Page(),
        ),
      );
    });
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

Widget x() {
  return Container(
    child: Text('1'),
  );
}

Widget y() {
  return Container(
    child: Text('2'),
  );
}
