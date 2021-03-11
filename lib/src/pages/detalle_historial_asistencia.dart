import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:notas/src/models/asistencia_local_model.dart';

class DetalleHistorialAsistencia extends StatefulWidget {
  @override
  _DetalleHistorialAsistenciaState createState() =>
      _DetalleHistorialAsistenciaState();
}

class _DetalleHistorialAsistenciaState
    extends State<DetalleHistorialAsistencia> {
  

  List<List<bool>> lista = new List();
  List<String> eleccion = new List();
  List<Asistencial> asis = new List();

  List<Asistencial> datosAsistencia;
  @override
  Widget build(BuildContext context) {
    datosAsistencia = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              margin: EdgeInsets.all(5.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.indigoAccent[700],
                  borderRadius: BorderRadius.circular(50.0)
                  ),
              //padding: EdgeInsets.all(4.0),
              child: IconButton(
                  icon: Image.asset("assets/img/icons/edit.png"),
                  onPressed: () {
                    Navigator.pushNamed(context, 'editar_asistencia',
                            arguments: datosAsistencia)
                        .then((val) => setState(() => {}));
                  })),
          SizedBox(
            width: 10.0,
          )
        ],
        title: Text('Asistencia'),
      ),
      body: _crearLista(datosAsistencia, context),
    );
  }

  Widget _crearLista(List<Asistencial> la, BuildContext context) {
    double alto = MediaQuery.of(context).size.height;
    double ancho = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: la.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: alto / 5,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.5),
              borderRadius: BorderRadius.circular(15)
            ),
            margin: EdgeInsets.all(5.0),
            color: Colors.blue[700],
            child: Container(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 1.0,
                        maxWidth: (ancho / 6) * 2.5,
                        minHeight: 1.0,
                        maxHeight: alto / 3,
                      ),
                      child: AutoSizeText(
                        la[index].nombreAlumno,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                    Expanded(
                        flex: 3, child: tipoAsistencia(la[index].tipoAsistencia)
                    ),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget tipoAsistencia(String index) {
    if (index == 'A') {
      return Container(
        child: Center(child: Text("ASISTIO")),
        color: Colors.green,
      );
    }
    if (index == 'F') {
      return Container(
        child: Center(child: Text("FALTA")),
        color: Colors.red,
      );
    }
    if (index == 'R') {
      return Container(
          color: Colors.yellow, child: Center(child: Text("RETRASO")));
    }
    if (index == 'L') {
      return Container(
        child: Center(child: Text("LICENCIA")),
        color: Colors.purple,
      );
    }
  }
}
