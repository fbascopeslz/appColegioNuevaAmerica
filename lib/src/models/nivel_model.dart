class Nivels {
  List<Nivel> items = new List();
  Nivels();

  Nivels.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final nivel = new Nivel.fromJson(item);
      items.add(nivel);
    }
  }
}

class Nivel {
    Nivel({
        this.id,
        this.nombre,
    });

    int id;
    String nombre;

    factory Nivel.fromJson(Map<String, dynamic> json) => Nivel(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}