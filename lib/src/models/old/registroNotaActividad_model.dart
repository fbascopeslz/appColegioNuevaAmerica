

import 'package:notas/src/models/old/actividad_model.dart';
import 'package:notas/src/models/old/registroNota_model.dart';

class RegistroNotaActividades {
  List<RegistroNotaActividad> items = new List();
  RegistroNotaActividades();

  RegistroNotaActividades.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final registroNotaActividad = new RegistroNotaActividad.fromJson(item);
      items.add(registroNotaActividad);
    }
  }
}

class RegistroNotaActividad {
    RegistroNotaActividad({
        this.id,
        this.registronota,
        this.actividad,
        this.nota,
    });

    int id;
    RegistroNota registronota;
    Actividad actividad;
    int nota;

    factory RegistroNotaActividad.fromJson(Map<String, dynamic> json) => RegistroNotaActividad(
        id: json["id"],
        registronota: json["registronota"],
        actividad: json["actividad"],
        nota: json["nota"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "registronota": registronota,
        "actividad": actividad,
        "nota": nota,
    };
}
