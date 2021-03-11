import 'package:http/http.dart' as http;
import 'package:notas/src/models/actividad_model.dart';
import 'dart:convert';

import 'bd.dart';

class ActividadesProvider {
  String _url = '192.168.0.13';
  BD bd = BD();

  Future<List<Actividad>> getActividades(int idoferta, int idArea, int periodo) async {
    _url = bd.url;
    final url = Uri.http(_url, 'api/actividades', {
      "OfertaID": idoferta.toString(),
      "AreaID": idArea.toString(),
      "Periodo": periodo.toString(),
    });
    print(url);
    final resp = await http.get(url);
    if (resp.statusCode==200) {
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    final actividads = new Actividades.fromJsonList(decodedData['data']);
    return actividads.items;
    } else {
      return null;
    }
  }

  Future<http.Response> setActividad(
    String indicador, String date, int areaid, int ofertaid, int periodo) async {
    _url = bd.url;
    Map data = {
      "Indicador": indicador,
      "Fecha": date,
      "AreaId": areaid,
      "OfertaId": ofertaid,
      "Periodo": periodo,
    };
    //encode Map to JSON
    var body = json.encode(data);
    print(body);

    final url = Uri.https(_url, 'api/actividades');
   // print(url);
    var headers = {'Content-Type': 'application/json'};

    var respuesta = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(respuesta.statusCode);
    print(respuesta.reasonPhrase);
  }

  Future<String> setActividad2(
    String indicador, String date, int areaid, int ofertaid) async {
    _url = bd.url;
    Map data = {
      "indicador": indicador,
      "fecha": date,
      "areaid": areaid,
      "ofertaid": ofertaid
    };
    //encode Map to JSON
    var body = json.encode(data);
    //print(body);

    final url = Uri.http(_url, 'api/actividades');
    //print(url);
    var headers = {
      'Content-Type': 'application/json',
      'Cookie':
          'ARRAffinity=0a3517ba6ed8bb14ffe517099672a3eb4ea3c4b710ad8c6e0edaa70c2d244335'
    };
    var request = http.Request('POST', url);
    request.followRedirects = false;
    request.body = body;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print(response.statusCode.toString() + "aqui el error");
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode.toString();
  }
}
