import 'package:flutter/material.dart';
import 'package:waterworks/ETC/color_green.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Palette.thisGreen,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new)),
            Text('บัญชี'),
            Text(''),
          ],
        ),
      ),
      backgroundColor: Palette.thisGreen,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: height * 0.43,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double innerHeight = constraints.maxHeight;
                  double innerWidth = constraints.maxWidth;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: innerHeight * 0.72,
                          width: innerWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 90,
                              ),
                              Text(
                                'คุณชำนาญ สู้งาน',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 71, 71, 71),
                                ),
                              ),
                              SizedBox(
                                height: 5,
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
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            child: Image.asset(
                              'assets/images/badge.png',
                              width: innerWidth * 0.45,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
