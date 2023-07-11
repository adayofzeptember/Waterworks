import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/customer_waterModel.dart';

class CustomersDatabase {
  static final CustomersDatabase instance = CustomersDatabase._init();
  static Database? _database;
  CustomersDatabase._init();
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('customer_water.db');

    return _database!;
  }

  // ฟังก์ชั่นสร้างฐานข้อมูล รับชื่อไฟล์ที่กำหนดเข้ามา
  Future<Database> _initDB(String filePath) async {
    // หาตำแหน่งที่จะจัดเก็บในระบบ ที่เตรียมไว้ให้
    final dbPath = await getDatabasesPath();
    // ต่อกับชื่อที่ส่งมา จะเป็น path เต็มของไฟล์
    final path = join(dbPath, filePath);
    // สร้างฐานข้อมูล และเปิดใช้งาน หากมีการแก้ไข ให้เปลี่ยนเลขเวอร์ชั่น เพิ่มขึ้นไปเรื่อยๆ
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // สร้างตาราง
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
   

    await db.execute('''CREATE TABLE $tableCustomers (
      ${CustomersFields.id} $idType,
      ${CustomersFields.data_id} $textType,
      ${CustomersFields.customer_id} $textType,
      ${CustomersFields.water_number} $textType,
      ${CustomersFields.area_number} $textType,
      ${CustomersFields.meter_number} $textType,
      ${CustomersFields.address} $textType,
      ${CustomersFields.type_id} $textType,
      ${CustomersFields.name} $textType,
      ${CustomersFields.status_debtor} $textType,
      ${CustomersFields.status_discount} $textType,
      ${CustomersFields.road} $textType
      )''');
  }

  Future<Customers> createCustomer(Customers customers) async {
    final db = await instance.database;

    final id = await db.insert(tableCustomers, customers.toJson());
    return customers.copy(id: id);
  }

  Future<Customers> selectByIdCustomers(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCustomers,
      columns: CustomersFields.values,
      where: '${CustomersFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Customers.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Customers>> selectAllCustomers() async {
    final db = await instance.database;
    const orderBy = '${CustomersFields.id} DESC';
    final result = await db.query(tableCustomers, orderBy: orderBy);
    return result.map((json) => Customers.fromJson(json)).toList();
  }

  Future<int> updateCustomers(Customers customer) async {
    final db = await instance.database;

    return db.update(
      tableCustomers,
      customer.toJson(),
      where: '${CustomersFields.id} = ?',
      whereArgs: [customer.id],
    );
  }

  Future<int> deleteByIdCustomers(int id) async {
    final db = await instance.database;
    return db.delete(
      tableCustomers,
      where: '${CustomersFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllCustomers() async {
    final db = await instance.database;
    return db.delete(
      tableCustomers,
    );
  }

  // คำสั่งสำหรับปิดฐานข้อมูล เท่าที่ลองใช้ เราไม่ควรปิด หรือใช้คำสั่งนี้
  // เหมือนจะเป็น bug เพราะถ้าปิดฐานข้อมูล จะอ้างอิงไม่ค่อยได้ ในตัวอย่าง
  // จะไม่ปิดหรือใช้คำสั่งนี้
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
