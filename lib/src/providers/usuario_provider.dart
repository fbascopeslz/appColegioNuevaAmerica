import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:notas/src/models/usuario_model.dart';
import 'package:notas/src/providers/bd.dart';

class UsuariosProvider {
  String _url = '192.168.0.13';
  BD bd = BD();
  Future<List<Usuario>> getUsuario(String usuario, String pass) async {
    _url = bd.url;
    final url = Uri.http(_url, 'api/usuarios', {
      'Usuario': usuario,
      'Contrasenia': pass,
    });
    //print(url);
    final resp = await http.get(url);
    if (resp.statusCode==200) {
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    final usuarios = new Usuarios.fromJsonList(decodedData['data']);
    return usuarios.items;
    } else {
      return null;
    }
  }
}

