import 'package:flutter/material.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            title: new Text("Simple Tab Demo"),
            backgroundColor: Color.fromARGB(255, 169, 191, 207),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: ("ยังไม่จด"),
                ),
                Tab(
                  text: ("จดแล้ว"),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            Center(
                child: Text(
              "One",
              style: TextStyle(fontSize: 50),
            )),
            Center(
                child: Text(
              "Two",
              style: TextStyle(fontSize: 50),
            )),
          ]),
        ),
      ),
    );
  }
}
