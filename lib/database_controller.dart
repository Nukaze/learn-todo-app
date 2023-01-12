import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';

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

class FirebaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserDocument(String email) async {
    try {
      final QuerySnapshot userSnapshot = await _db.collection("users").where("user_email", isEqualTo: email).get();
      Map<String, dynamic> userDocument = userSnapshot.docs.first.data() as Map<String, dynamic>;
      userDocument.addAll({"user_id": userSnapshot.docs.first.id});
      return userDocument;
    } catch (e) {
      return {};
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      // final password, salt = getAuthPasswordCheck(checkPassword, validPassword, salt)
      final UserCredential authRes = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return authRes;
    } catch (e) {
      dprint("in firebase controller with exception: \n$e");
      return null;
    }
  }

  Future<void> signUp(String email, String password, String salt) async {}
}
