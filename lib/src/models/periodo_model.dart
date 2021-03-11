
class Periodos {
  List<Periodo> items = new List();
  Periodos();

  Periodos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final periodo = new Periodo.fromJson(item);
      items.add(periodo);
    }
  }
}

class Periodo {
    Periodo({
        this.id,
        this.numero,
        this.fechainicio,
        this.fechafin,
        this.anio,
        this.descripcion,
    });

    int id;
    int numero;
    String fechainicio;
    String fechafin;
    int anio;
    String descripcion;

    factory Periodo.fromJson(Map<String, dynamic> json) => Periodo(
        id: json["id"],
        numero: json["numero"],
        fechainicio: json["fechainicio"],
        fechafin: json["fechafin"],
        anio: json["anio"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "numero": numero,
        "fechainicio": fechainicio,
        "fechafin": fechafin,
        "anio": anio,
        "descripcion": descripcion,
    };
}
