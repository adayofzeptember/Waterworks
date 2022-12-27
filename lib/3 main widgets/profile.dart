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
            Text(''),
            Text('ข้อมูลผู้จด'),
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
              height: 10,
            ),
            Stack(
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
                          'The King in the North',
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
                                      color: Color.fromARGB(255, 83, 83, 83)),
                                ),
                                Text(
                                  'เขตงานที่รับผิดชอบ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 83, 83, 83)),
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
                                  borderRadius: BorderRadius.circular(100),
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
                                      color: Color.fromARGB(255, 83, 83, 83)),
                                ),
                                Text(
                                  'ตอนงานที่รับผิดชอบ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 83, 83, 83)),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 85,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/rob.jpg'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
