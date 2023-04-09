import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/bloc/load_done/done_bloc.dart';
import 'package:waterworks/bloc/load_undone/undone_bloc.dart';
import 'package:waterworks/bloc/search/search_bloc.dart';
import 'package:waterworks/bloc/write_page/write_page_bloc.dart';
import 'package:waterworks/screens/First_Page_bottomBar.dart'; 
import 'package:waterworks/screens/login.dart';
import 'bloc/printer_connect/printer_connect_bloc.dart';
import 'bloc/profile/profile_bloc.dart';
import 'offline/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


void main() { 
  Intl.defaultLocale = 'th';
  WidgetsFlutterBinding.ensureInitialized();
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      Phoenix(
        child: Start_Page_Waterworks(),
      ),
    ),
  );
}

class Start_Page_Waterworks extends StatelessWidget {
  Start_Page_Waterworks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotWriteBloc()),
        BlocProvider(create: (context) => DoneBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        // BlocProvider(create: (context) => CheckboxBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
 BlocProvider(create: (context) => PrinterConnectBloc()),
        // BlocProvider(create: (context) => RadioCheckBloc()),
        BlocProvider(create: (context) => WritePageBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('th', 'TH'),
        ],
        theme: ThemeData(
          primarySwatch: Palette.thisGreen,
          fontFamily: 'Kanit',
        ),
        home: const Load_Page(),
        builder: EasyLoading.init(),
      ),
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
    check();
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

  Future<void> check() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //print('connected');
        _Load_And_Go();
        print('connected');
        context.read<ProfileBloc>().add(LoadProfile());
        await _Load_And_Go();
      }
    } on SocketException catch (_) {
      print('not connected');
      showMyDialog(
        context,
        () {
          Navigator.pop(context);
          loadingInternet();
          Future.delayed(const Duration(seconds: 3), () {
            check();
          });
          setState(() {});
        },
      );
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
              duration: const Duration(milliseconds: 820),
              type: PageTransitionType.bottomToTop,
              child: Login()),
        );
      });
    } else {
      await Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          PageTransition(
              duration: const Duration(milliseconds: 820),
              type: PageTransitionType.bottomToTop,
              child: Menu_Page()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
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
                  padding: const EdgeInsets.only(top: 100),
                  child: Image.asset('assets/images/badge.png'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'การประปาเทศบาลนคร',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
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
