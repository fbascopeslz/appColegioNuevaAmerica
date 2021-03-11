class Areas {
  List<Area> items = new List();
  Areas();

  Areas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final area = new Area.fromJson(item);
      items.add(area);
    }
  }
}

class Area {
  Area({
    this.id,
    this.nombre,
  });

  setArea(int id) {
    this.id = id;
    this.nombre = " ";
  }

  int id;
  String nombre;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
