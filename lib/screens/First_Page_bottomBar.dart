import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/screens/3%20main%20screens/profile.dart';
import 'package:waterworks/screens/3%20main%20screens/search.dart';
import 'package:waterworks/ETC/color_green.dart';
import 'package:waterworks/bloc/load_undone/undone_bloc.dart';
import 'package:waterworks/bloc/search/search_bloc.dart';
import '3 main screens/list_Main.dart';


class Menu_Page extends StatefulWidget {
  Menu_Page({Key? key}) : super(key: key);

  @override
  State<Menu_Page> createState() => _Menu_PageState();
}

class _Menu_PageState extends State<Menu_Page> {
  List<Widget> _widgetsPages = [Water_Unit_List(), Search_Page(), Profile()];
  int _index = 0;
  void _onItemTapped(int index2) {
    setState(() {
      _index = index2;
      if (_index == 1) {
        context.read<SearchBloc>().add(ClearSearch());
      }
      context.read<NotWriteBloc>().add(Load_unDoneData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetsPages.elementAt(_index),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset.zero),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  height: 30,
                  color: Palette.thisGreen,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  color: Color.fromARGB(255, 194, 194, 194),
                  height: 30,
                ),
                label: 'หน้าหลัก'),
            BottomNavigationBarItem(
                activeIcon: CircleAvatar(
                  backgroundColor: Palette.thisGreen,
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                icon: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 194, 194, 194),
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                label: 'ค้นหา'),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/person.svg',
                  height: 30,
                  color: Palette.thisGreen,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/person.svg',
                  color: Color.fromARGB(255, 194, 194, 194),
                  height: 30,
                ),
                label: 'บัญชี')
          ],
        ),
      ),
    );
  }
}
