import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';
import 'package:notas/src/models/inscripcion_model.dart';

import 'package:notas/src/models/registroNota.dart';
import 'package:notas/src/providers/inscripciones_provider.dart';
import 'package:notas/src/providers/registro_notas_provider.dart';
import 'package:notas/src/utils/mensajes.dart';

import 'dialogs.dart';

class CalificarAlumno extends StatefulWidget {
  @override
  _CalificarAlumnoState createState() => _CalificarAlumnoState();
}

class _CalificarAlumnoState extends State<CalificarAlumno> {
  RegistroNotasProvider rn = new RegistroNotasProvider();
  List<RegistroNota> _listaNotasActuales = new List();
  List<TextEditingController> _controllerTextField =
      new List<TextEditingController>();
  DatosBasicos datosBasicos;

  List<NuevaNota> nn = new List();

  @override
  Widget build(BuildContext context) {
    datosBasicos = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(datosBasicos.actividad.area.nombre),
        actions: [
          Container(
              margin: EdgeInsets.all(5.0),
              alignment: Alignment.center,
         decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0)),
              //padding: EdgeInsets.all(4.0),
              child: IconButton(
                  icon: Image.asset("assets/img/icons/save.png"),
              onPressed: () {
                _handleSubmit(context);
              })),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
      body: cargarNotaActual(),
    );
  }

  Widget cargarNotaActual() {
    return FutureBuilder<List<RegistroNota>>(
      future: rn.getRegistroNotas(
          datosBasicos.actividad.id, datosBasicos.oferta.gestion,datosBasicos.periodo),
      initialData: [],
      builder:
          (BuildContext context, AsyncSnapshot<List<RegistroNota>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        _listaNotasActuales = snapshot.data;
        return cargarAlumnos();
      },
    );
  }

  Widget cargarAlumnos() {
    InscripcionessProvider pa = new InscripcionessProvider();

    return FutureBuilder(
      future: pa.getAlumnos(
          datosBasicos.oferta.cursoParalelo.id, datosBasicos.gestion),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Text('No Tienes alumnos asignados.'),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final alumnos = snapshot.data;

        if (alumnos.length == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return _crearLista(alumnos, context);
      },
    );
  }

  Widget _crearLista(List<Inscripcion> la, BuildContext context) {
    nn.clear();
    return ListView.builder(
      itemCount: la.length,
      itemBuilder: (BuildContext context, int index) {
        Container encabezado = new Container();
        if (index == 0) {
          encabezado = new Container(
            child: Column(
              children: [
                Text(
                  datosBasicos.actividad.indicador,
                  style: TextStyle(fontSize: 30.0),
                ),
                Divider(
                  color: Colors.blue,
                  height: 30.0,
                  thickness: 5.0,
                )
              ],
            ),
          );
        }
        NuevaNota _rn = new NuevaNota();

        String _notaActual = recuperarNotaActual(la[index].alumno.id);
        _controllerTextField.add(new TextEditingController());
        if (_notaActual != "") {
          _rn.nota = int.parse(_notaActual);
        }
        _controllerTextField[index].text = _notaActual;

        _rn.actividadid = datosBasicos.actividad.id;
        _rn.inscripcionid = la[index].id;
        _rn.periodoid = datosBasicos.periodo;  //antes periodo era 1
        nn.add(_rn);

        return Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              encabezado,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${index + 1}. ' + la[index].alumno.nombre,
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controllerTextField[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        nn[index].nota = int.parse(value);
                      },
                      onEditingComplete: () {
                        verificarNota(
                            index, nn[index].nota.toString(), context);
                      },
                      decoration: InputDecoration(
                        labelText: "Nota",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
              Divider(
                color: Colors.red,
              )
            ],
          ),
        );
      },
    );
  }

  void verificarNota(int index, String nota, BuildContext context) {
    int notamin = 1;
    int notamax = 100;

    if (isNumeric(nota) &&
        int.parse(nota) > notamin &&
        notamax > int.parse(nota)) {
      _controllerTextField[index].text = nota;
      //FocusScope.of(context).unfocus();
    } else {
      //print("entro a else");
      String mensaje =
          "La nota debe ser numerica, minimo {$notamin}pt y maximo de {$notamax} pts";
      MostrarMensaje(mensaje, context);
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  String recuperarNotaActual(int idalumno) {
    String _nota = "";
    _listaNotasActuales.forEach((element) {
      if (element.inscripcion.alumno.id == idalumno) {
        _nota = element.nota.toString();
      }
    });
    return _nota;
  }

  void imprimir() {
    RegistroNotasProvider rn = new RegistroNotasProvider();
    //Map<String,List<NuevaNota>> l = ["registronotas":]
    Map m = {"registronotas": nn};
    rn.setRegistroNotas(json.encode(m));
    //print(json.encode(m));
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future<void> _handleSubmit(BuildContext context) async {
    String resp = "";
    try {
      Dialogs.showLoadingDialog(context, _keyLoader); //invoking login
      RegistroNotasProvider rn = new RegistroNotasProvider();
      nn.removeWhere((element) => element.nota == null);
      print(nn);
      Map m = {"registronotas": nn};
      resp = await rn.setRegistroNotas(json.encode(m));
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .pop(); //close the dialoge
      //Navigator.pushReplacementNamed(context, "calificar_alumnos");

    } catch (error) {
      print(error);
    }
    //resp = "a";
    if (resp == "202") {
      Dialogs.exito(context);
    } else {
      Dialogs.fallo(context);
    }
  }
}

class NuevaNotas {
  List<Map<String, dynamic>> items = new List();
  NuevaNotas();

  NuevaNotas.fromMaps(List<NuevaNota> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      //final actividad = new NuevaNota.;
      items.add(item.toJson());
    }
  }
}

class NuevaNota {
  NuevaNota({
    this.inscripcionid,
    this.actividadid,
    this.periodoid,
    this.nota,
  });

  int inscripcionid;
  int actividadid;
  int periodoid;
  int nota;

  factory NuevaNota.fromJson(Map<String, dynamic> json) => NuevaNota(
        inscripcionid: json["inscripcionid"],
        actividadid: json["actividadid"],
        periodoid: json["periodoid"],
        nota: json["nota"],
      );

  Map<String, dynamic> toJson() => {
        "inscripcionid": inscripcionid,
        "actividadid": actividadid,
        "periodoid": periodoid,
        "nota": nota,
      };
}
