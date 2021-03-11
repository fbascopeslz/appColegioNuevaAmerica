import 'dart:convert';

import 'package:notas/src/models/privilegio_model.dart';

class Grupos {
  List<Grupo> items = new List();
  Grupos();

  Grupos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final grupo = new Grupo.fromJson(item);
      items.add(grupo);
    }
  }
}

class Grupo {
  Grupo({
    this.id,
    this.nombre,
    this.privilegios,
  });

  int id;
  String nombre;
  List<Privilegio> privilegios;

  factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        id: json["id"],
        nombre: json["nombre"],
        privilegios: new Privilegios().listaprinvilegios(json["privilegios"])
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "privilegios": privilegios,
      };
}
