import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waterworks/bloc/bottom%20menu%20switch/bottom_menu_switch_bloc.dart';
import 'package:waterworks/screens/main%20screens/profile.dart';
import 'package:waterworks/screens/main%20screens/search_page.dart';
import 'package:waterworks/ETC/color_green.dart';

import 'list units/list_Main.dart';

class Bottom_bar_page extends StatefulWidget {
  Bottom_bar_page({Key? key}) : super(key: key);

  @override
  State<Bottom_bar_page> createState() => _Bottom_bar_pageState();
}

class _Bottom_bar_pageState extends State<Bottom_bar_page> {
  List<Widget> _widgetsPages = [Water_Unit_List(), Search_Page(), Profile()];

  _onItemTapped(int index) {
    context.read<BottomMenuSwitchBloc>().add(SwitchIndex(getIndex: index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomMenuSwitchBloc, BottomMenuSwitchState>(
      builder: (context, state) {
        return Scaffold(
          body: _widgetsPages.elementAt(state.index),
          bottomNavigationBar: Container(
            // height: 80,
            decoration: const BoxDecoration(
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
              selectedLabelStyle: TextStyle(color: Palette.thisGreen),
              unselectedLabelStyle: TextStyle(color: Colors.white),
              currentIndex: state.index,
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
                      color: const Color.fromARGB(255, 194, 194, 194),
                      height: 30,
                    ),
                    label: 'หน้าหลัก'),
                const BottomNavigationBarItem(
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
                      color: const Color.fromARGB(255, 194, 194, 194),
                      height: 30,
                    ),
                    label: 'บัญชี')
              ],
            ),
          ),
        );
      },
    );
  }
}
