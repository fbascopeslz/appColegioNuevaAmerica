

class Alumnos {
  List<Alumno> items = new List();
  Alumnos();

  Alumnos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final alumno = new Alumno.fromJson(item);
      items.add(alumno);
    }
  }
}

class Alumno {
    Alumno({
        this.id,
        this.ci,
        this.nombre,
        this.fechaNac,
        this.sexo,
        this.direccion,
        this.telefono,
        this.email,
        this.fotografia,
        this.usuario,
    });

    int id;
    int ci;
    String nombre;
    String fechaNac;
    String sexo;
    String direccion;
    String telefono;
    String email;
    String fotografia;
    UsuarioAlum usuario;

    factory Alumno.fromJson(Map<String, dynamic> json) => Alumno(
        id: json["id"],
        ci: json["ci"],
        nombre: json["nombre"],
        fechaNac: json["fechaNac"],
        sexo: json["sexo"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        fotografia: json.containsKey("fotografia")?json["fotografia"]:null,
        email: json["email"],
        usuario: UsuarioAlum.fromJson(json["usuario"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ci": ci,
        "nombre": nombre,
        "fechaNac": fechaNac,
        "sexo": sexo,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
        "fotografia": fotografia,
        "usuario": usuario,
    };
}

class UsuarioAlum {
  UsuarioAlum({
    this.id,
    this.usuario,
    this.contrasenia,
  });

  int id;
  String usuario;
  String contrasenia;

  factory UsuarioAlum.fromJson(Map<String, dynamic> json) => UsuarioAlum(
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