import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notas/src/models/asistencia_local_model.dart';
import 'package:notas/src/providers/asistencia_provider.dart';
import 'package:notas/src/utils/mensajes.dart';

import 'dialogs.dart';

class EditarAsistencia extends StatefulWidget {
  @override
  _EditarAsistenciaState createState() => _EditarAsistenciaState();
}

class _EditarAsistenciaState extends State<EditarAsistencia> {
  List<List<bool>> lista = new List();
  List<String> eleccion = new List();
  List<Asistencial> asis = new List();
  bool bandera = false;

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
                  //color: Colors.white,
                  border: Border.all(color: Colors.white,width: 2.0),
                  borderRadius: BorderRadius.circular(50.0)),
              //padding: EdgeInsets.all(4.0),
              child: IconButton(
                  icon: Image.asset("assets/img/icons/save.png"),
                  onPressed: () => guardarAsistencia())),
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
                  Expanded(flex: 3, child: opcionesAsistencia(index)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget opcionesAsistencia(int index) {
    bool a = false;
    bool f = false;
    bool r = false;
    bool l = false;
    List<bool> l1 = new List();
    l1 = [a, f, r, l];
    lista.add(l1);
    eleccion.add("");
    if (!bandera) {
      set_opcion(index);
      if (index >= datosAsistencia.length - 1) {
        bandera = true;
      }
    }
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // [Monday] checkbox
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "A",
                style: TextStyle(fontSize: 25.0),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: Checkbox(
                  value: lista[index][0],
                  onChanged: (bool value) {
                    setState(() {
                      lista[index][0] = value;
                      lista[index][1] = false;
                      lista[index][2] = false;
                      lista[index][3] = false;
                      datosAsistencia[index].tipoAsistencia = "A";
                    });
                  },
                ),
              ),
            ],
          ),
          // [Tuesday] checkbox
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "F",
                style: TextStyle(fontSize: 25.0),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: Checkbox(
                  value: lista[index][1],
                  onChanged: (bool value) {
                    setState(() {
                      lista[index][0] = false;
                      lista[index][1] = value;
                      lista[index][2] = false;
                      lista[index][3] = false;
                      datosAsistencia[index].tipoAsistencia = "F";
                    });
                  },
                ),
              ),
            ],
          ),
          // [Wednesday] checkbox
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "R",
                style: TextStyle(fontSize: 25.0),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: Checkbox(
                  value: lista[index][2],
                  onChanged: (bool value) {
                    setState(() {
                      lista[index][0] = false;
                      lista[index][1] = false;
                      lista[index][2] = value;
                      lista[index][3] = false;
                      datosAsistencia[index].tipoAsistencia = "R";
                    });
                  },
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "L",
                style: TextStyle(fontSize: 25.0),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple[600],
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: Checkbox(
                  value: lista[index][3],
                  onChanged: (bool value) {
                    setState(() {
                      lista[index][0] = false;
                      lista[index][1] = false;
                      lista[index][2] = false;
                      lista[index][3] = value;
                      datosAsistencia[index].tipoAsistencia = "L";
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void set_opcion(index) {
    String op = datosAsistencia[index].tipoAsistencia;
    switch (op) {
      case "A":
        {
          lista[index][0] = true;
        }
        break;
      case "F":
        {
          lista[index][1] = true;
        }
        break;
      case "R":
        {
          lista[index][2] = true;
        }
        break;
      case "L":
        {
          lista[index][3] = true;
        }
        break;
    }
  }

  

  Future<void> guardarAsistencia() async {
    String resp = "";
    //Asistencial aux = new Asistencial();
    AsistencialProvider ap = AsistencialProvider();

    try {
      //var fecha = DateFormat("yyyy-MM-dd H:mm:ss").format(DateTime.now()).toString();
      datosAsistencia.forEach((element) async {
        //element.fecha = fecha;
        var salida = await ap.updateAsistencial(element);
        print("respuesta update asistencia:" + salida.toString());
      });
      resp = "202";
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); //close the dialog

    } catch (error) {
      print(error);
    }
    //resp = "a";
    if (resp == "202") {
      await Dialogs.exito(context);
      Navigator.pop(context);
    } else {
      Dialogs.fallo(context);
    }
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
}
