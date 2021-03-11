import 'nivel_model.dart';

class Cursos {
  List<Curso> items = new List();
  Cursos();

  Cursos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final curso = new Curso.fromJson(item);
      items.add(curso);
    }
  }
}

class Curso {
  Curso({
    this.id,
    this.nombre,
    this.nivel,
    this.nombrenum,
  });

  int id;
  String nombre;
  Nivel nivel;
  int nombrenum;

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        id: json["id"],
        nombre: json["nombre"],
        nivel: Nivel.fromJson(json["nivel"]),
        nombrenum : json["nombrenum"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "nivel": nivel,
        "nombrenum": nombrenum,
      };
}
