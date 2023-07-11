import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:waterworks/offline/detail_customer.dart';
import 'package:waterworks/offline/models/customer_waterModel.dart';
import 'package:waterworks/offline/office_route.dart';
import 'package:waterworks/offline/service/customers_db.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchController = TextEditingController();
  List<dynamic> usersData = [], users = [];
  late Future<List<Customers>> customer;
  void getUser() async {
    customer.then(
      (value) {
        for (var el in value) {
          usersData.add({
            "id": el.data_id,
            "name": el.name,
            "water_number": el.water_number,
            "area_number": el.area_number,
            "address": el.address,
            "mater_number": el.meter_number,
          });
          print(el.meter_number);
        }
      },
    );

    users = await usersData;
    setState(() {});
  }

  void searchFilter(text) {
    if (text != "") {
      users = usersData
          .where((user) =>
              user['name'].toLowerCase().contains(text.toLowerCase()) ||
                      user['water_number']
                          .toLowerCase()
                          .contains(text.toLowerCase()) ||
                      user['area_number']
                          .toLowerCase()
                          .contains(text.toLowerCase()) ||
                      user['address'].toLowerCase().contains(text.toLowerCase())
                  ? true
                  : false)
          .toList();
    } else {
      users = usersData;
    }
    setState(() {});
  }

  Future<void> deleteAll() async {
    await _db.deleteAllCustomers(); // ทำคำสั่งลบข้อมูลทั้งหมด
    getUser();
    setState(() {});
  }

  // sqlite
  late CustomersDatabase _db;
  late Future<List<Customers>> usersModel;
  int i = 0;

  @override
  void initState() {
    _db = CustomersDatabase.instance;
    customer = _db.selectAllCustomers();
    // TODO: implement initState
    getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onChanged: (val) {
            searchFilter(val);
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.white,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
                getUser();
                // createUsers();
              },
              icon: const Icon(Icons.clear, color: Colors.white),
            ),
          ),
          cursorColor: Colors.black,
          style: const TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      // ignore: unnecessary_null_comparison
      body: (users != null)
          ? ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(milliseconds: 300),
                            type: PageTransitionType.rightToLeft,
                            child: DetailCustomer(
                              cus_name: user['name'],
                              area_number: user['area_number'],
                              water_number: user['water_number'],
                              address: user['address'],
                              matWater: user['mater_number'],
                            )),
                      );
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          Text(user['name']),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('เลข ป: ${user['water_number']}'),
                              SizedBox(width: 20),
                              Text('เขต: ${user['area_number']}'),
                            ],
                          ),
                          Text('ที่อยู่: ${user['address']}'),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Container(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          deleteAll();
          Navigator.push(context, pageOffice());
        },
        label: Text('ลบข้อมูลทั้งหมด'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
