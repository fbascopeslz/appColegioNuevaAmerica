import 'package:notas/src/models/asistencia_local_model.dart';
import 'package:sqflite/sqflite.dart';


import 'bd.dart';

class AsistencialProvider {
  Database db;

  insert(Asistencial asistencial) async {
    db = await BDLocal.db.database;
    final res = await db.insert('asistencia', asistencial.toJson());
    return res;
  }

  Future<List<Asistencial>> getAsistencialIdOfertaPeriodo(int id, int idperiodo) async {
    db = await BDLocal.db.database;
    final res = await db.query('asistencia', where: 'ofertaid=? and periodoid=?', whereArgs: [id,idperiodo]);
    List<Asistencial> list =
        res.isNotEmpty ? res.map((e) => Asistencial.fromJson(e)).toList() : null;
    return list;
    //return res.isNotEmpty ? Asistencial.fromJson(res.first) : null;
  }

  Future<List<Asistencial>> getAsistencialIdCarrito(int id) async {
    db = await BDLocal.db.database;
    final res = await db.query('asistencia', where: 'idcarrito=?', whereArgs: [id]);
    List<Asistencial> list =
        res.isNotEmpty ? res.map((e) => Asistencial.fromJson(e)).toList() : null;
    return list;
  }

  Future<List<Asistencial>> getAll() async {
    db = await BDLocal.db.database;
    final res = await db.query('asistencia');
    List<Asistencial> list =
        res.isNotEmpty ? res.map((e) => Asistencial.fromJson(e)).toList() : null;
    return list;
  }

  updateAsistencial(Asistencial asistencial) async {
    db = await BDLocal.db.database;
    final res = db.update('asistencia', asistencial.toJson(),
        where: 'id = ?', whereArgs: [asistencial.id]);
    return res; // retorna el numero de id,s actualizados
  }

  deleteAsistencial(int id) async {
    db = await BDLocal.db.database;
    final res = db.delete('asistencia', where: 'id=?', whereArgs: [id]);
    return res; // retorna el numero de filas eliminadas
  }

  
}
