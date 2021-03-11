import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notas/src/models/registroNota.dart';
import 'package:notas/src/providers/bd.dart';

class RegistroNotasProvider {
  String _url = '192.168.0.13';
  BD bd = BD();
  Future<List<RegistroNota>> getRegistroNotasXinscripcion(
      int idInscripcion, int periodo) async {
    _url = bd.url;
    final url = Uri.http(_url, 'api/registro-notas', {
      "InscripcionId": idInscripcion.toString(),
      "PeriodoId": periodo.toString(),
    });

    final resp = await http.get(url);
    // print(url);
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    final actividads = new RegistroNotas.fromJsonList(decodedData['data']);
    return actividads.items;
  }

  Future<List<RegistroNota>> getRegistroNotas(
      int idactividad, int gestion, int periodo) async {
    _url = bd.url;
    final url = Uri.http(_url, 'api/registro-notas', {
      "ActividadId": idactividad.toString(),
      "PeriodoId": periodo.toString()
    });
    //print(url);
    final resp = await http.get(url);
    // print(url);
    final decodedData = json.decode(resp.body);
    // print(decodedData);
    final actividads = new RegistroNotas.fromJsonList(decodedData['data']);
    return actividads.items;
  }

  Future<String> setRegistroNotas(String listaNotasNuevas) async {
    _url = bd.url;
    //encode Map to JSON
    var body = listaNotasNuevas;
    //print(listaNotasNuevas);
    final url = Uri.https(_url, 'api/registro-notas/establecer-notas');
    //print(url);
    var headers = {'Content-Type': 'application/json'};

    var respuesta = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(respuesta.statusCode);
    print(respuesta.reasonPhrase);
    return respuesta.statusCode.toString();
  }

  Future<String> setRegistroNotas2(String listaNotasNuevas) async {
    _url = bd.url;
    var body = listaNotasNuevas;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse(_url + '/api/registro-notas/establecer-notas'));
    request.body = body;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode.toString();
  }
}
