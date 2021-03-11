import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:notas/src/models/oferta_model.dart';
import 'package:notas/src/providers/bd.dart';

class OfertasProvider {
  String _url = '192.168.0.13';
  BD bd = BD();

  Future<List<Oferta>> getOfertas(int profesorId) async {
    _url = bd.url;
    final url = Uri.http(_url, 'api/ofertas', {
      'ProfesorId': profesorId.toString(),
    });
    //print(url);
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      final oferta = new Ofertas.fromJsonList(decodedData['data']);
      return oferta.items;
    } else {
      return null;
    }
  }
}
