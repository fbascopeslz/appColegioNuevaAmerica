import 'package:http/http.dart' as http;
import 'package:notas/src/models/alumno_model.dart';
import 'dart:convert';

import 'package:notas/src/providers/bd.dart';

class AlumnosProvider {
  String _url = '192.168.0.13';
  BD bd = BD();

  Future<List<Alumno>> getAlumnos() async {
    _url = bd.url;
    final url = Uri.http(_url, 'api/alumnos');
    //print(url);
    final resp = await http.get(url);
    //final encodedata = json.encode(resp.body);
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    final alumnos = new Alumnos.fromJsonList(decodedData['data']);
    return alumnos.items;
  }


  Future<String> updateAlumno(Alumno alum) async {
    _url = bd.url;
    //encode Map to JSON
    var body = json.encode(alum);
    //print(body);
    final url = Uri.https(_url, 'api/alumnos/${alum.id}');
    //print(url);
    var headers = {'Content-Type': 'application/json'};

    var respuesta = await http.put(
      url,
      headers: headers,
      body: body,
    );

    print(respuesta.statusCode);
    print(respuesta.reasonPhrase);
    return respuesta.statusCode.toString();
  }
}
