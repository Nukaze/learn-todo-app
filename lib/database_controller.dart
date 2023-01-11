import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tools.dart';

class Sqlitebase {
  static Database? _database;
  static String? _databasePath;

  _Sqlitebase() {}

  Future<void> createDatabasePath(String? dbName) async {
    if (dbName!.isEmpty) {
      dbName = "my_database.db";
    }
    if (!dbName.contains(".db")) {
      dbName += ".db";
    }
    _databasePath = await getDatabasesPath() + "/" + dbName;
    dprint("db path = $_databasePath");
  }

  Future<void> createTable(String tableName) async {
    try {
      Database db = await openDatabase(
        _databasePath!,
        version: 1,
        onCreate: (db, version) async {
          await db.execute("CREATE TABLE $tableName(uid INTEGER PRIMARY KEY, email TEXT, password INTEGER);");
        },
      );
      dprint("table has been created.");
    } catch (e) {
      dprint("Catch : $e");
    }
  }
}

class FirebaseController {}
