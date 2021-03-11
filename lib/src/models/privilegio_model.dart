class Privilegios {
  List<Privilegio> items = new List();
  Privilegios();

  Privilegios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final privilegio = new Privilegio.fromJson(item);
      items.add(privilegio);
    }
  }

  List<Privilegio> listaprinvilegios(List<dynamic> jsonList) {
    if (jsonList == null) return null;

    for (var item in jsonList) {
      final privilegio = new Privilegio.fromJson(item);
      items.add(privilegio);
    }
      return items;
  }
}

class Privilegio {
  Privilegio({
    this.id,
    this.nombre,
  });

  int id;
  String nombre;

  factory Privilegio.fromJson(Map<String, dynamic> json) => Privilegio(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
