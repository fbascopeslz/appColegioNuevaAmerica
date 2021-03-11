

import 'package:notas/src/models/alumno_model.dart';
import 'package:notas/src/models/cursoParalelo_model.dart';

class Inscripciones {
  List<Inscripcion> items = new List();
  Inscripciones();

  Inscripciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final inscripcion = new Inscripcion.fromJson(item);
      items.add(inscripcion);
    }
  }
}

class Inscripcion {
    Inscripcion({
        this.id,
        this.fecha,
        this.cursoParalelo,
        this.alumno,
    });

    int id;
    String fecha;
    CursoParalelo cursoParalelo;
    Alumno alumno;

    factory Inscripcion.fromJson(Map<String, dynamic> json) => Inscripcion(
        id: json["id"],
        fecha: json["fecha"],
        cursoParalelo:CursoParalelo.fromJson(json["cursoParalelo"]) ,
        alumno: Alumno.fromJson(json["alumno"]) ,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
        "CursoParalelo": cursoParalelo,
        "Alumno": alumno,
    };
}