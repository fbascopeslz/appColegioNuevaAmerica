
import 'package:notas/src/models/alumno_model.dart';
import 'package:notas/src/models/old/oferta_model.dart';
import 'package:notas/src/models/periodo_model.dart';

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
        this.notamateria,
        this.alumno,
        this.oferta,
        this.periodo,
    });

    int id;
    int notamateria;
    Alumno alumno;
    Oferta oferta;
    Periodo periodo;

    factory RegistroNota.fromJson(Map<String, dynamic> json) => RegistroNota(
        id: json["id"],
        notamateria: json["notamateria"],
        alumno: json["alumno"],
        oferta: json["oferta"],
        periodo: json["periodo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "notamateria": notamateria,
        "alumno": alumno,
        "oferta": oferta,
        "periodo": periodo,
    };
}