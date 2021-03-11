import 'dart:core';

import 'package:flutter/material.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';
import 'package:notas/src/models/alumno_model.dart';
import 'package:notas/src/models/inscripcion_model.dart';
import 'package:notas/src/models/registroNota.dart';
import 'package:notas/src/providers/inscripciones_provider.dart';
import 'package:notas/src/providers/registro_notas_provider.dart';

class Calificaciones extends StatefulWidget {
  @override
  _CalificacionesState createState() => _CalificacionesState();
}

class _CalificacionesState extends State<Calificaciones> {
  DatosBasicos db;
  double notaaux = 0;
  List<dynamic> alumnos = new List();
  List<double> notas_finales = new List();
  List<double> saber = new List();
  List<double> hacer = new List();
  List<double> ser = new List();
  @override
  Widget build(BuildContext context) {
    db = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Calificaciones"),
      ),
      body: cargarAlumnos(),
    );
  }

  Widget cargarAlumnos() {
    InscripcionessProvider pa = new InscripcionessProvider();

    return FutureBuilder(
      future: pa.getAlumnos(db.oferta.cursoParalelo.id, db.oferta.gestion),
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

        alumnos = snapshot.data;

        if (alumnos.length == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return calcularXAlumno(alumnos, context);
      },
    );
  }

  Widget calcularXAlumno(List<Inscripcion> lista, BuildContext context) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (BuildContext context, int index) {
        return resumenNotas(lista[index], context);
      },
    );
  }

  //obtengo todos los registro de ese id de inscripcion
  Widget resumenNotas(Inscripcion ins, BuildContext context) {
    RegistroNotasProvider rn = new RegistroNotasProvider();

    return FutureBuilder(
      future: rn.getRegistroNotasXinscripcion(ins.id, db.periodo),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final registroNotas = snapshot.data;
        if (registroNotas.length == 0) {
          //return Center(child: Text("No hay datos"),);
          return ListTile(
            title: Text(ins.alumno.nombre),
            trailing: Text(
              "Faltan Notas",
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        return _crearLista2(registroNotas, context);
      },
    );
  }

  //dividira todas las notas en las areas y calcula nota final
  Widget _crearLista2(List<RegistroNota> registroNotas, BuildContext context) {
    List<String> areas = ['SER-DECIDIR', 'SABER', 'HACER'];
    List<Color> colores = [
      Colors.indigo,
      Colors.grey[600],
      Colors.deepPurple[400]
    ];

    List<double> notasxarea = new List();
    registroNotas.forEach((element) {});
    for (var i = 1; i <= 3; i++) {
      notasxarea.add(calcularNotaDimension(registroNotas, i));
    }

    double notafinal = calcularNotaFinal(notasxarea);
    Text textnotaf = new Text("");
    if (notafinal >= 70) {
      textnotaf = Text(
        notafinal.round().toString(),
        style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
      );
    }

    if (notafinal >= 51 && notafinal<=69) {
      textnotaf = Text(
        notafinal.round().toString(),
        style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold),
      );
    }

    if (notafinal <= 50) {
      textnotaf = Text(
        notafinal.round().toString(),
        style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
      );
    }
    return ListTile(
      title: Text(registroNotas[0].inscripcion.alumno.nombre),
      trailing: textnotaf,
      //Text(calcularNotaFinal(notasxarea).round().toString())
    );
  }

  double calcularNotaDimension(List<RegistroNota> lista, int index) {
    notaaux = 0;
    int cont = 0;
    lista.forEach((element) {
      if (element.actividad.area.id == index) {
        notaaux += element.nota;
        cont++;
      }
    });
    notaaux = notaaux / cont;
    switch (index) {
      case 1:
        return notaaux = notaaux * 0.10;
        break;
      case 2:
        return notaaux = notaaux * 0.45;
        break;
      case 3:
        return notaaux = notaaux * 0.45;
        break;
      default:
        return 0;
    }
  }

  double calcularNotaFinal(List<double> listaNotasDimension) {
    double nf = 0;
    listaNotasDimension.forEach((element) {
      nf += element;
    });
    return nf;
  }
}
