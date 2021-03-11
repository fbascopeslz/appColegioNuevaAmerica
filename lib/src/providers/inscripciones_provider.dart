import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:notas/src/models/inscripcion_model.dart';
import 'package:notas/src/providers/bd.dart';

class InscripcionessProvider {
  String _url = '192.168.0.13';
  BD bd = BD();
  
  Future<List<Inscripcion>> getAlumnos(int cursoParaleloId, int gestion) async {
    _url = bd.url;
    final url = Uri.http(_url, 'api/inscripciones', {
      'CursoParaleloId': cursoParaleloId.toString(),
      'Gestion': gestion.toString(),
    });
    //print(url);
    final resp = await http.get(url);
    //final encodedata = json.encode(resp.body);
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    final inscripcioness = new Inscripciones.fromJsonList(decodedData['data']);
    return inscripcioness.items;
  }
}
