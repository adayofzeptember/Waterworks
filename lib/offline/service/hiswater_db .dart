// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/history_waterModel.dart';

class HisWaterDatabase {
  static final HisWaterDatabase instance = HisWaterDatabase._init();
  static Database? _database;
  HisWaterDatabase._init();
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('his_water.db');

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

    await db.execute('''CREATE TABLE $tableHisWater (
      ${HisWaterFields.id} $idType,
      ${HisWaterFields.data_id},
      ${HisWaterFields.water_number},
      ${HisWaterFields.area_number},
      ${HisWaterFields.status},
      ${HisWaterFields.record_date},
      ${HisWaterFields.current_unit}
      )''');
  }

  Future<HisWater> createHisWater(HisWater hisWater) async {
    final db = await instance.database;

    final id = await db.insert(tableHisWater, hisWater.toJson());
    return hisWater.copy(id: id);
  }

  Future<HisWater> selectByIdHisWaters(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableHisWater,
      columns: HisWaterFields.values,
      where: '${HisWaterFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return HisWater.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<HisWater>> selectAllHisWater() async {
    final db = await instance.database;
    const orderBy = '${HisWaterFields.id} DESC';
    final result = await db.query(tableHisWater, orderBy: orderBy);
    return result.map((json) => HisWater.fromJson(json)).toList();
  }

  Future<int> updateHisWater(HisWater customer) async {
    final db = await instance.database;

    return db.update(
      tableHisWater,
      customer.toJson(),
      where: '${HisWaterFields.id} = ?',
      whereArgs: [customer.id],
    );
  }

  Future<int> deleteByIdHisWater(int id) async {
    final db = await instance.database;
    return db.delete(
      tableHisWater,
      where: '${HisWaterFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllHisWater() async {
    final db = await instance.database;
    return db.delete(
      tableHisWater,
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
