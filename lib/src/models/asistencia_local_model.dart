class Asistencials {
  List<Asistencial> items = new List();
  Asistencials();

  Asistencials.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final asistencial = new Asistencial.fromJson(item);
      items.add(asistencial);
    }
  }
}

class Asistencial {
  Asistencial({
    this.id,
    this.fecha,
    this.tipoAsistencia,
    this.nombreAlumno,
    this.alumnoid,
    this.ofertaid,
    this.periodoid,
  });

  int id;
  String fecha;
  String tipoAsistencia;
  String nombreAlumno;
  int alumnoid;
  int ofertaid;
  int periodoid;

  factory Asistencial.fromJson(Map<String, dynamic> json) => Asistencial(
        id: json["id"],
        fecha: json["fecha"],
        tipoAsistencia: json["tipoAsistencia"],
        nombreAlumno: json["nombreAlumno"],
        alumnoid: json["alumnoid"],
        ofertaid: json["ofertaid"],
        periodoid : json["periodoid"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
        "tipoAsistencia": tipoAsistencia,
        "nombreAlumno": nombreAlumno,
        "alumnoid": alumnoid,
        "ofertaid": ofertaid,
        "periodoid": periodoid,
      };
}
