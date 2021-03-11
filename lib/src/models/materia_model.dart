class Materias {
  List<Materia> items = new List();
  Materias();

  Materias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final materia = new Materia.fromJson(item);
      items.add(materia);
    }
  }
}

class Materia {
    Materia({
        this.id,
        this.nombre,
    });

    int id;
    String nombre;

    factory Materia.fromJson(Map<String, dynamic> json) => Materia(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
