import 'dart:developer';

import 'package:alarm_app/screens/add_or_update_alarm/model/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static Database? _database;
  static String tableName = 'alarm';
  static String columnId = 'id';
  static String columnLabel = 'label';
  static String columnDateTime = 'alarmSetTime';

  static Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    // Get a location using getDatabasesPath
    var dir = await getDatabasesPath();
    var path = "${dir}alarm.db";

    // open the database
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // When creating the db, create the table
        db.execute('''
          create table $tableName ( 
          $columnId integer primary key autoincrement, 
          $columnLabel text not null,
          $columnDateTime text not null)
        ''');
      },
    );
    log(database.toString());
    return database;
  }

  static void addAlarm({required AlarmModel alarmModel}) async {
    var db = await database;
    var result = await db.insert(tableName, alarmModel.toMap());
    log('result : $result');
  }

  static Future<List<AlarmModel>> getAlarms() async {
    List<AlarmModel> alarms = [];

    var db = await database;
    var result = await db.query(tableName);
    for (var element in result) {
      var alarmModel = AlarmModel.fromMap(element);
      alarms.add(alarmModel);
    }

    return alarms;
  }

  static Future<int> update(AlarmModel model) async {
    var db = await database;
    return await db.update(tableName, model.toMap(),
        where: '$columnId = ?', whereArgs: [model.id]);
  }

  static Future<int> delete(int? id) async {
    var db = await database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
