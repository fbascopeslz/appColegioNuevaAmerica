import 'dart:io';
import 'package:notas/src/providers/scriptBD.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class BD {
  //final String url = '192.168.0.13';
  final String url = 'notascolegio.azurewebsites.net';
  BD._privateConstructor();

  static final BD _instance = BD._privateConstructor();

  factory BD() {
    return _instance;
  }
}

class BDLocal {
  static Database _database;
  static final BDLocal db = BDLocal._();

  BDLocal._();

  Future<Database> get database async {
    // print('base de datos iniciando creacion!');
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print(documentsDirectory);
    final path = join(documentsDirectory.path, 'NotasColegio.db');
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      String str = scriptBD();
      var arr = str.split(';');
      arr.forEach((element) async {
         print('ejecutando:   $element');
        if (element != '') {
          await db.execute(element);
        }
      });
    });
  }
}
