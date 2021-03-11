class Paralelos {
  List<Paralelo> items = new List();
  Paralelos();

  Paralelos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final paralelo = new Paralelo.fromJson(item);
      items.add(paralelo);
    }
  }
}

class Paralelo {
    Paralelo({
        this.id,
        this.nombre,
    });

    int id;
    String nombre;

    factory Paralelo.fromJson(Map<String, dynamic> json) => Paralelo(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}