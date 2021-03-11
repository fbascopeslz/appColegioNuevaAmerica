import 'package:flutter/material.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';
import 'package:notas/src/models/asistencia_local_model.dart';
import 'package:notas/src/providers/asistencia_provider.dart';

Widget resumenAsistencia(DatosBasicos db, BuildContext context) {
  AsistencialProvider rn = new AsistencialProvider();

  return FutureBuilder(
    future: rn.getAsistencialIdOfertaPeriodo(db.oferta.id, db.periodo),
    initialData: null,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.data == null) {
        return Container(
          height: 100.0,
          child: Card(
            color: Colors.yellow[800],
            child: Center(child: Text("No Registra Asistencias",style: TextStyle(fontWeight: FontWeight.bold),),)
            ),
        );
      }

      if (!snapshot.hasData) {
        return Center(child: CircularProgressIndicator());
      }

      final registroNotas = snapshot.data;
      if (registroNotas.length == 0) {
        return _crearLista([], context, db);
      }

      return _crearLista(registroNotas, context, db);
    },
  );
}


Widget _crearLista(
    List<Asistencial> asistencia, BuildContext context, DatosBasicos db) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 1,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        color: Colors.green[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                  child: Text("Asistencia",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
            DataTable(
                sortColumnIndex: 1,
                columns: [
                  DataColumn(label: Text('Fecha')),
                  DataColumn(label: Text('Asistencia')),
                ],
                rows: _listaAsistencia(asistencia, context, index + 1, db)),
          ],
        ),
      );
      //child: _listaXArea2(registroNotas, context, index + 1)),
    },
  );
}

List<DataRow> _listaAsistencia(List<Asistencial> asistencia,
    BuildContext context, int areaid, DatosBasicos db) {
  List<DataRow> lr = new List();

  asistencia.forEach((element) {
    print(asistencia);
    if (element.alumnoid == db.alumno.id && element.periodoid == db.periodo) {
      List<DataCell> l = new List();
      l.add(DataCell((Text(element.fecha))));
      l.add(DataCell(Text(element.tipoAsistencia)));
      DataRow dr = new DataRow(
          cells: l,
          color: MaterialStateColor.resolveWith((states) {
            switch (element.tipoAsistencia) {
              case "A":
                return Colors.green[300];
                break;
              case "F":
                return Colors.red[300];
                break;
              case "R":
                return Colors.yellow[300];
                break;
              case "L":
                return Colors.purple[300];
                break;
              default:
                return Colors.white;
            }
          }));
      lr.add(dr);
    }
  });
  return lr;
}
