
import '../area_model.dart';

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
        this.indicador,
        this.fecha,
        this.area,
    });

    int id;
    String indicador;
    String fecha;
    Area area;
    

    factory Actividad.fromJson(Map<String, dynamic> json) => Actividad(
        id: json["id"],
        indicador: json["indicador"],
        fecha: json["fecha"],
        area: Area.fromJson(json["area"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "indicador": indicador,
        "fecha": fecha,
        "area": area,
    };
}
