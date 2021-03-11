class Profesores {
  List<Profesor> items = new List();
  Profesores();

  Profesores.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final profesor = new Profesor.fromJson(item);
      items.add(profesor);
    }
  }
}

class Profesor {
  Profesor({
    this.id,
    this.ci,
    this.nombre,
    this.fechaNac,
    this.sexo,
    this.direccion,
    this.telefono,
    this.email,
    this.usuarioProf,
  });

  int id;
  int ci;
  String nombre;
  DateTime fechaNac;
  String sexo;
  String direccion;
  String telefono;
  String email;
  UsuarioProf usuarioProf;

  factory Profesor.fromJson(Map<String, dynamic> json) => Profesor(
        id: json["id"],
        ci: json["ci"],
        nombre: json["nombre"],
        fechaNac: DateTime.parse(json["fechaNac"]),
        sexo: json["sexo"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        email: json["email"],
        usuarioProf: UsuarioProf.fromJson(json["usuario"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ci": ci,
        "nombre": nombre,
        "fechaNac": fechaNac.toIso8601String(),
        "sexo": sexo,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
        "usuarioProf": usuarioProf.toJson(),
      };
}

class UsuarioProf {
  UsuarioProf({
    this.id,
    this.usuario,
    this.contrasenia,
  });

  int id;
  String usuario;
  String contrasenia;

  factory UsuarioProf.fromJson(Map<String, dynamic> json) => UsuarioProf(
        id: json["id"],
        usuario: json["usuario"],
        contrasenia: json["contrasenia"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "contrasenia": contrasenia,
      };
}
