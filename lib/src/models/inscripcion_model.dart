import 'alumno_model.dart';
import 'cursoParalelo_model.dart';

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
        this.gestion,
        this.cursoParalelo,
        this.alumno,
    });

    int id;
    DateTime fecha;
    int gestion;
    CursoParalelo cursoParalelo;
    Alumno alumno;

    factory Inscripcion.fromJson(Map<String, dynamic> json) => Inscripcion(
        id: json["id"],
        fecha: DateTime.parse(json["fecha"]),
        gestion: json["gestion"],
        cursoParalelo: CursoParalelo.fromJson(json["cursoParalelo"]),
        alumno: Alumno.fromJson(json["alumno"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha.toIso8601String(),
        "gestion": gestion,
        "cursoParalelo": cursoParalelo.toJson(),
        "alumno": alumno.toJson(),
    };
}