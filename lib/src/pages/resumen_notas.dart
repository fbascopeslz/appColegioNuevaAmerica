import 'package:flutter/material.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';
import 'package:notas/src/models/registroNota.dart';
import 'package:notas/src/providers/registro_notas_provider.dart';

bool banderaColor = false;
List<int> calculoSum = new List();
Widget resumenNotas(DatosBasicos db, BuildContext context) {
  RegistroNotasProvider rn = new RegistroNotasProvider();

  return FutureBuilder(
    future: rn.getRegistroNotasXinscripcion(db.idInscripcion, db.periodo),
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
        return _crearLista2([], context, db);
      }

      return _crearLista2(registroNotas, context, db);
    },
  );
}

Widget _crearLista2(
    List<RegistroNota> registroNotas, BuildContext context, DatosBasicos db) {
  List<String> areas = ['SER-DECIDIR', 'SABER', 'HACER'];
  List<Color> colores = [Colors.indigo,Colors.grey[600],Colors.deepPurple[400]];

  return ListView.builder(
    scrollDirection: Axis.vertical,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 3,
    itemBuilder: (BuildContext context, int index) {
      calculoSum.clear();
      return Card(
        color: colores[index],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                  child: Text(areas[index],
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
            DataTable(
                sortColumnIndex: 1,
                columns: [
                  DataColumn(label: Text('ACTIVIDAD', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('NOTA', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold))),
                ],
                rows: _listaXArea2(registroNotas, context, index + 1, db,colores[index])),
          ],
        ),
      );
      //child: _listaXArea2(registroNotas, context, index + 1),
    },
  );
}

List<DataRow> _listaXArea2(List<RegistroNota> registroNotas,
    BuildContext context, int areaid, DatosBasicos db,Color color) {
  List<DataRow> lr = new List();

  registroNotas.forEach((element) {
    if (element.actividad.area.id == areaid &&
        element.actividad.oferta.id == db.oferta.id) {
      List<DataCell> l = new List();
      l.add(DataCell((Text(element.actividad.indicador))));
      l.add(DataCell(Text(element.nota.toString())));
      calculoSum.add(element.nota);
      DataRow dr = new DataRow(
          cells: l,
          color: MaterialStateColor.resolveWith((states) {
            if (banderaColor) {
              banderaColor = false;
              return Colors.grey[400];
            } else {
              banderaColor = true;
              return Colors.grey[300];
            }
          }));
      lr.add(dr);
    }
  });

  //calculo del promedio area
  double total = 0;
  calculoSum.forEach((element) {
    total += element;
  });
  total = total / calculoSum.length;

  List<DataCell> l = new List();
  l.add(DataCell((Text(
    "PROMEDIO",
    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
  ))));
  l.add(DataCell(Text(
    total.toString(),
    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
  )));
  DataRow dr = new DataRow(cells: l);
  lr.add(dr);
  return lr;
}
