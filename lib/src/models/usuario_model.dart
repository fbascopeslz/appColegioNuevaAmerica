import 'dart:convert';

import 'grupo_model.dart';

class Usuarios {

  List<Usuario> items = new List();
  Usuarios();

  Usuarios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final usuario = new Usuario.fromJson(item);
      items.add(usuario);
    }
    
  }
}


class Usuario {
    Usuario({
        this.id,
        this.usuario,
        this.contrasenia,
        this.grupo,
    });

    int id;
    String usuario;
    String contrasenia;
    Grupo grupo;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        usuario: json["usuario"],
        contrasenia: json["contrasenia"],
        grupo: Grupo.fromJson(json["grupo"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "contrasenia": contrasenia,
        "grupo": grupo,
    };
}
