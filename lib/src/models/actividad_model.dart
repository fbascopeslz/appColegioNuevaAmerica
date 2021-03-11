import 'area_model.dart';
import 'oferta_model.dart';

class Actividades {
  List<Actividad> items = new List();
  Actividades();

  Actividades.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final actividad = new Actividad.fromJson(item);
      items.add(actividad);
    }
  }
}

class Actividad {
  Actividad({
    this.id,
    this.oferta,
    this.indicador,
    this.fecha,
    this.area,
    this.periodo,
  });

  int id;
  Oferta oferta;
  String indicador;
  DateTime fecha;
  Area area;
  int periodo;

  factory Actividad.fromJson(Map<String, dynamic> json) => Actividad(
        id: json["id"],
        oferta: Oferta.fromJson(json["oferta"]),
        indicador: json["indicador"],
        fecha: DateTime.parse(json["fecha"]),
        area: Area.fromJson(json["area"]),
        periodo: json["Periodo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "oferta": oferta.toJson(),
        "indicador": indicador,
        "fecha": fecha.toIso8601String(),
        "area": area.toJson(),
        "periodo" : periodo,
      };
}
