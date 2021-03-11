import 'package:notas/src/models/alumno_model.dart';
import 'actividad_model.dart';
import 'area_model.dart';
import 'oferta_model.dart';

class DatosBasicos {
  DatosBasicos({
    this.id,
    this.oferta,
    this.alumno,
    this.actividad,
    this.gestion,
    this.idUsuario,
    this.periodo,
  });

  DatosBasicos2() {
    this.idUsuario = 0;
    this.id = 0;
    this.oferta = new Oferta();
    this.alumno = new Alumno();
    this.area = new Area();
    this.actividad = new Actividad();
    this.actividad.oferta = this.oferta;
    this.actividad.area = this.area;
    this.gestion = 2020;
    idInscripcion = null;
  }

  int idUsuario = 0;
  int id = 0;
  Oferta oferta;
  Alumno alumno;
  Actividad actividad;
  Area area;
  int gestion = 2020;
  int idInscripcion;
  int periodo = 1;

  factory DatosBasicos.fromJson(Map<String, dynamic> json) => DatosBasicos(
        id: json["id"],
        oferta: Oferta.fromJson(json["Oferta"]),
        alumno: Alumno.fromJson(json["Alumno"]),
        actividad: Actividad.fromJson(json["Actividad"]),
        gestion: json["gestion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "oferta": oferta.toJson(),
        "Alumno": alumno.toJson(),
        "Actividad": actividad.toJson(),
        "gestion": gestion,
        "area": area,
      };
}
