import 'package:flutter/foundation.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import '../database/data.dart';


class UserController {

  static final _db = Database(NativeDatabase.memory());

  static Future<List<User>> getData () async {
    final db = _db;
    List<User> result = await db.select(db.users).get();
    return result;
  }

  static Future<String> insertUser (name,email,password) async {

   try {
     final db = _db;
      int result = await db.into(db.users).insert(UsersCompanion.insert(name: name, email: email, password: password));
     return '200';
   }catch (e) {
     return 'error';
   }
  }

  static Future<String> deleteUser (id) async {
    try {
      final db = _db;
      var result = await (db.delete(db.users)..where((tbl) => tbl.id.equals(id))).go();
      return result.toString();
    }catch (e) {
      return e.toString();
    }
  }

  static Future<User> detailUser (id) async {
    User user;
    final db = _db;
    final result = await (db.select(db.users)..where((tbl) => tbl.id.equals(id))).get();
    user = result[0];

    return user;

  }

  static Future<String> updateUser (id,name,password,imageBytes) async{

    try {
      final user = UsersCompanion(
          name: Value(name),
          password: Value(password),
          image: Value(imageBytes)
      );
      final db = _db;
      final result = await db.update(db.users)..where((tbl) => tbl.id.equals(id))..write(user);
      return 'success';
    }catch (e) {
      return (e).toString();
    }

    return '' ;
  }

}