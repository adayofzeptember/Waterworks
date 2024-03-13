// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/waterModel.dart';

class WatersDatabase {
  static final WatersDatabase instance = WatersDatabase._init();
  static Database? _database;
  WatersDatabase._init();
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('water.db');

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

    await db.execute('''CREATE TABLE $tableWater (
      ${WaterFields.id} $idType,
      ${WaterFields.numPor} $textType,
      ${WaterFields.zone} $textType,
      ${WaterFields.numMeter} $textType,
      ${WaterFields.saveDate} $textType
      )''');
  }

  // คำสั่งสำหรับเพิ่มข้อมูลใหม่ คืนค่าเป็น book object ที่เพิ่มไป
  Future<Water> create(Water water) async {
    final db = await instance.database;

    final id = await db.insert(tableWater, water.toJson());
    return water.copy(id: id);
  }

  // คำสั่งสำหรับแสดงข้อมูล id ที่ส่งมา
  Future<Water> selectByIdWater(int id) async {
    final db = await instance.database;

    // ทำคำสั่งคิวรี่ข้อมูลตามเงื่อนไข
    final maps = await db.query(
      tableWater,
      columns: WaterFields.values,
      where: '${WaterFields.id} = ?',
      whereArgs: [id],
    );

    // ถ้ามีข้อมูล แสดงข้อมูลกลับออกไป
    if (maps.isNotEmpty) {
      return Water.fromJson(maps.first);
    } else {
      // ถ้าไม่มีแสดง error
      throw Exception('ID $id not found');
    }
  }

  // คำสั่งแสดงทั้งหมด ต้องส่งกลับเป็น List
  Future<List<Water>> selectAllWater() async {
    final db = await instance.database;
    const orderBy = '${WaterFields.id} DESC';
    final result = await db.query(tableWater, orderBy: orderBy);
    return result.map((json) => Water.fromJson(json)).toList();
  }

  // อัปเดทข้อมูล
  Future<int> updateWater(Water water) async {
    final db = await instance.database;

    return db.update(
      tableWater,
      water.toJson(),
      where: '${WaterFields.id} = ?',
      whereArgs: [water.id],
    );
  }

  // คำสั่งสำหรับลบข้อมล รับค่า id ที่จะลบ
  Future<int> deleteByIdWater(int id) async {
    final db = await instance.database;
    return db.delete(
      tableWater,
      where: '${WaterFields.id} = ?',
      whereArgs: [id],
    );
  }

  // คำสั่งสำหรับลบข้อมูลทั้งหมด
  Future<int> deleteAllWater() async {
    final db = await instance.database;
    return db.delete(
      tableWater,
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
