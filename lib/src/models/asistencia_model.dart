class AsistenciaModelo {
  AsistenciaModelo({
    this.id,
    this.fecha,
    this.hora,
    this.idTipoAsistencia,
    this.idOferta,
    this.idAlumno,
    this.idPeriodo  
  });

  int id;
  String fecha;
  String hora;
  int idTipoAsistencia;
  int idOferta;
  int idAlumno;
  int idPeriodo;

  factory AsistenciaModelo.fromJson(Map<String, dynamic> json) => AsistenciaModelo(
    id: json["Id"],
    fecha: json["Fecha"],
    hora: json["Hora"],
    idTipoAsistencia: json["idTipoAsistencia"],
    idOferta: json["idOferta"],
    idAlumno: json["idAlumno"],
    idPeriodo: json["idPeriodo"]        
  );

  Map<String, dynamic> toJson() => {
    /*
    "Id": id,
    "Fecha": fecha,
    "Hora": hora,
    */
    "IdTipoAsistencia": idTipoAsistencia,
    "IdOferta": idOferta,
    "IdAlumno": idAlumno,
    "IdPeriodo": idPeriodo
  };
}