

import 'package:notas/src/models/cursoParalelo_model.dart';
import 'package:notas/src/models/materia_model.dart';


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
        this.cursoParalelo,
        this.gestion,
    });

    int id;
    Materia materia;
    ProfesorOferta profesor;
    CursoParalelo cursoParalelo;
    int gestion;

    factory Oferta.fromJson(Map<String, dynamic> json) => Oferta(
        id: json["id"],
        materia: Materia.fromJson(json["materia"]),
        profesor: ProfesorOferta.fromJson(json["profesor"]),
        cursoParalelo: CursoParalelo.fromJson(json["cursoParalelo"]),
        gestion: json["gestion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "materia": materia.toJson(),
        "profesor": profesor.toJson(),
        "cursoParalelo": cursoParalelo.toJson(),
        "gestion": gestion,
    };
}


class ProfesorOferta {
    ProfesorOferta({
        this.id,
        this.ci,
        this.nombre,
        this.fechaNac,
        this.sexo,
        this.direccion,
        this.telefono,
        this.email,
    });

    int id;
    int ci;
    String nombre;
    DateTime fechaNac;
    String sexo;
    String direccion;
    String telefono;
    String email;

    factory ProfesorOferta.fromJson(Map<String, dynamic> json) => ProfesorOferta(
        id: json["id"],
        ci: json["ci"],
        nombre: json["nombre"],
        fechaNac: DateTime.parse(json["fechaNac"]),
        sexo: json["sexo"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ci": ci,
        "nombre": nombre,
        "fechaNac": fechaNac.toIso8601String(),
        "sexo": sexo,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
    };
}