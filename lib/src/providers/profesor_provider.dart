import 'package:http/http.dart' as http;
import 'package:notas/src/models/profesor_model.dart';
import 'dart:convert';

import 'package:notas/src/providers/bd.dart';

class ProfesoresProvider {
  String _url = '192.168.0.13';
  BD bd = BD();
  Future<int> getProfesorXIdUsuario(int usuario) async {
    _url = bd.url;
    final url =
        Uri.http(_url, 'api/profesores', {'usuarioId': usuario.toString()});
    //print(url);
    final resp = await http.get(url);
    //final encodedata = json.encode(resp.body);
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    final usuarios = new Profesores.fromJsonList(decodedData['data']);
    return usuarios.items[0].id;
  }
}
