

import 'package:sqflite/sqflite.dart';
import 'database_connection.dart';

class Repository{
  DatabaseConnection? _databaseConnection;
  Repository()
  {
    _databaseConnection=DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async
  {
     if(_database!=null) return _database;
     _database=await _databaseConnection!.setDatabase();
     return _database;
  }
  /// Inserting data to a table
  /// ///  return int = inserted raw Id
  insertData(table,data) async
  {
    var connection=await database;
    return await connection!.insert(table, data);
  }
  /// Reading data to a table
  ///  return List of table Mapped data
  readData(table) async
  {
    var connection=await database;
    return await connection!.query(table);
  }
  ///  where: "id = ?",whereArgs: [object.id],
  readDataWithCondition(table,where) async
    {
      var connection=await database;
      return await connection!.query(table,where: where);
    }
  readDataWithConditionArg(table,where,whereArg) async
  {
    var connection=await database;
    return await connection!.query(table,where: where,whereArgs: whereArg);
  }
  readDataWithQuery(query) async
  {
    var connection=await database;
    return await connection!.rawQuery(query);
  }
  /// Update Data
  ///  where: "id = ?",whereArgs: [factory.id],
  ///  return int =number of affected raws
  ///
  updateSalesOrderData(table,data,where,whereArg) async
  {
    var connection=await database;
    return await connection!.update(table, data, where: where,whereArgs: [whereArg]);
  }
  updateUserDate(table,data,where,whereArg) async
  {
    var connection=await database;
    return await connection!.rawUpdate(
        'UPDATE $table SET name = ? , email =?, phone_number=?',
        ['$data','$where','$whereArg']);

  }
  updateUserApiDate(table,userUpdate,userName) async
  {
    var connection=await database;
    return await connection!.rawUpdate(
        'UPDATE $table SET lastModifiedDate = ? where username =?',
        ['$userUpdate','$userName']);

  }

  updateData(table,data,where,whereArg) async
  {
    var connection=await database;
    return await connection!.update(table, data, where: where,whereArgs: [whereArg]);
  }
  updateSalesModifyDate(table,data,where,whereArg) async
  {
    var connection=await database;
    //return await connection.update(table, data, where: where,whereArgs: [whereArg]);
    return await connection!.rawUpdate(
        'UPDATE $table SET lastModifiedDate = ? ',
        ['$data']);
  }

  deleteData(table,where,whereArg) async
  {
    var connection=await database;
    return await connection!.delete(table, where: where,whereArgs: [whereArg]);
  }


}