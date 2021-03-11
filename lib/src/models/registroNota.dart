import 'package:notas/src/models/periodo_model.dart';

import 'area_model.dart';

class RegistroNotas {
  List<RegistroNota> items = new List();
  RegistroNotas();

  RegistroNotas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final registroNota = new RegistroNota.fromJson(item);
      items.add(registroNota);
    }
  }
}

class RegistroNota {
  RegistroNota({
    this.id,
    this.inscripcion,
    this.periodo,
    this.actividad,
    this.nota,
  });

  int id;
  Inscripcion2 inscripcion;
  Periodo periodo;
  Actividad actividad;
  int nota;

  factory RegistroNota.fromJson(Map<String, dynamic> json) => RegistroNota(
        id: json["id"],
        inscripcion: Inscripcion2.fromJson(json["inscripcion"]),
        periodo: Periodo.fromJson(json["periodo"]),
        actividad: Actividad.fromJson(json["actividad"]),
        nota: json["nota"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Inscripcion": inscripcion.toJson(),
        "periodo": periodo.toJson(),
        "actividad": actividad.toJson(),
        "nota": nota,
      };
}

class Actividad {
    Actividad({
        this.id,
        this.oferta,
        this.indicador,
        this.fecha,
        this.area,
    });

    int id;
    Oferta oferta;
    String indicador;
    DateTime fecha;
    Area area;

    factory Actividad.fromJson(Map<String, dynamic> json) => Actividad(
        id: json["id"],
        oferta: Oferta.fromJson(json["oferta"]),
        indicador: json["indicador"],
        fecha: DateTime.parse(json["fecha"]),
        area: Area.fromJson(json["area"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "oferta": oferta.toJson(),
        "indicador": indicador,
        "fecha": fecha.toIso8601String(),
        "area": area.toJson(),
    };
}
class Inscripcion2 {
  Inscripcion2({
    this.id,
    this.fecha,
    this.gestion,
    this.alumno,
  });

  int id;
  DateTime fecha;
  int gestion;
  Alumno alumno;

  factory Inscripcion2.fromJson(Map<String, dynamic> json) => Inscripcion2(
        id: json["id"],
        fecha: DateTime.parse(json["fecha"]),
        gestion: json["gestion"],
        alumno: Alumno.fromJson(json["alumno"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha.toIso8601String(),
        "gestion": gestion,
        "alumno": alumno.toJson(),
      };
}

class Alumno {
  Alumno({
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

  factory Alumno.fromJson(Map<String, dynamic> json) => Alumno(
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

class Oferta {
    Oferta({
        this.id,
        this.gestion,
    });

    int id;
    int gestion;

    factory Oferta.fromJson(Map<String, dynamic> json) => Oferta(
        id: json["id"],
        gestion: json["gestion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "gestion": gestion,
    };
}


