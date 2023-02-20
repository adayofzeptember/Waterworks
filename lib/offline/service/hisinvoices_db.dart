import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/history_invoicesModel.dart';

class HisInvoicesDatabase {
  static final HisInvoicesDatabase instance = HisInvoicesDatabase._init();
  static Database? _database;
  HisInvoicesDatabase._init();
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('his_invoices_water.db');

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
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''CREATE TABLE $tableHisInvoices (
      ${HisInvoicesFields.id} $idType,
      ${HisInvoicesFields.data_id} $textType,
      ${HisInvoicesFields.customer_water_id} $textType,
      ${HisInvoicesFields.customer_name} $textType,
      ${HisInvoicesFields.water_number} $textType,
      ${HisInvoicesFields.area_number} $textType,
      ${HisInvoicesFields.sum} $textType,
      ${HisInvoicesFields.status} $textType,
      ${HisInvoicesFields.issue_date_format} $textType,
      ${HisInvoicesFields.vat} $textType,
      ${HisInvoicesFields.total} $textType,
      ${HisInvoicesFields.sum_service} $textType,
      ${HisInvoicesFields.bill_no} $textType
      )''');
  }

  Future<HisInvoices> createHisInvoices(HisInvoices hisInvoices) async {
    final db = await instance.database;

    final id = await db.insert(tableHisInvoices, hisInvoices.toJson());
    return hisInvoices.copy(id: id);
  }

  Future<HisInvoices> selectByIdHisInvoicess(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableHisInvoices,
      columns: HisInvoicesFields.values,
      where: '${HisInvoicesFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return HisInvoices.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<HisInvoices>> selectAllHisInvoices() async {
    final db = await instance.database;
    const orderBy = '${HisInvoicesFields.id} DESC';
    final result = await db.query(tableHisInvoices, orderBy: orderBy);
    return result.map((json) => HisInvoices.fromJson(json)).toList();
  }

  Future<int> updateHisInvoices(HisInvoices customer) async {
    final db = await instance.database;

    return db.update(
      tableHisInvoices,
      customer.toJson(),
      where: '${HisInvoicesFields.id} = ?',
      whereArgs: [customer.id],
    );
  }

  Future<int> deleteByIdHisInvoices(int id) async {
    final db = await instance.database;
    return db.delete(
      tableHisInvoices,
      where: '${HisInvoicesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllHisInvoices() async {
    final db = await instance.database;
    return db.delete(
      tableHisInvoices,
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
