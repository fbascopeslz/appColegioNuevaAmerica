

import 'package:notas/src/models/cursoParalelo_model.dart';
import 'package:notas/src/models/profesor_model.dart';
import '../materia_model.dart';

class Ofertas {
  List<Oferta> items = new List();
  Ofertas();

  Ofertas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final oferta = new Oferta.fromJson(item);
      items.add(oferta);
    }
  }
}

class Oferta {
    Oferta({
        this.id,
        this.materia,
        this.profesor,
        this.cursoparalelo,
    });

    int id;
    Materia materia;
    Profesor profesor;
    CursoParalelo cursoparalelo;

    factory Oferta.fromJson(Map<String, dynamic> json) => Oferta(
        id: json["id"],
        materia: Materia.fromJson(json["materia"]),
        profesor: Profesor.fromJson(json["profesor"]),
        cursoparalelo: CursoParalelo.fromJson(json["cursoParalelo"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "materia": materia,
        "profesor": profesor,
        "cursoparalelo": cursoparalelo,
    };
}