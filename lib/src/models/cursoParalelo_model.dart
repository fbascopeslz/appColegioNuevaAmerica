import 'package:notas/src/models/paralelo_model.dart';
import 'curso_model.dart';

class CursoParalelos {
  List<CursoParalelo> items = new List();
  CursoParalelos();

  CursoParalelos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final cursoParalelo = new CursoParalelo.fromJson(item);
      items.add(cursoParalelo);
    }
  }
}

class CursoParalelo {
    CursoParalelo({
        this.id,
        this.curso,
        this.paralelo,
    });

    int id;
    Curso curso;
    Paralelo paralelo;

    factory CursoParalelo.fromJson(Map<String, dynamic> json) => CursoParalelo(
        id: json["id"],
        curso: Curso.fromJson(json["curso"]),
        paralelo: Paralelo.fromJson(json["paralelo"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "curso": curso,
        "paralelo": paralelo,
    };
}