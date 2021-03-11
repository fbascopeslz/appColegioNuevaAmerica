import 'package:flutter/material.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';

class MateriaView extends StatelessWidget {
  DatosBasicos datosbasicos;
  @override
  Widget build(BuildContext context) {
    datosbasicos = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          datosbasicos.oferta.materia.nombre,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: contenido(context),
    );
  }

  Widget contenido(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double alto = MediaQuery.of(context).size.height;
    return ListView(
      //mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: alto / 3,
          width: ancho,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'lista_dimensiones',
                  arguments: datosbasicos);
            },
            child: Card(
              margin: EdgeInsets.all(10.0),
              color: Colors.cyan[700],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Center(
                          child: Text("Registro",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold)))),
                  Container(
                      padding: EdgeInsets.only(right: 10.0),
                      width: 120.0,
                      height: 120.0,
                      child:
                          Image(image: AssetImage('assets/img/registro.png')))
                ],
              ),
            ),
          ),
        ),
        Container(
          height: alto / 3,
          width: ancho,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'lista_alumnos',
                  arguments: datosbasicos);
            },
            child: Card(
              margin: EdgeInsets.all(10.0),
              color: Colors.deepPurpleAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Center(
                          child: Text("Lista Alumnos",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold)))),
                  Container(
                      padding: EdgeInsets.only(right: 10.0),
                      width: 120.0,
                      height: 120.0,
                      child: Image(image: AssetImage('assets/img/alumnos.png')))
                ],
              ),
            ),
          ),
        ),
        Container(
          height: alto / 3,
          width: ancho,
          child: GestureDetector(
            onTap: () {              

              Navigator.pushNamed(context, 'asistencia', arguments: datosbasicos);
            
            },
            child: Card(
              margin: EdgeInsets.all(10.0),
              color: Colors.lightBlue[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Center(
                          child: Text("Asistencia",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold)))),
                  Container(
                      padding: EdgeInsets.only(right: 10.0),
                      width: 120.0,
                      height: 120.0,
                      child:
                          Image(image: AssetImage('assets/img/asistencia.png')))
                ],
              ),
            ),
          ),
        ),
        Container(
          height: alto / 3,
          width: ancho,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'historial_asistencia',
                  arguments: datosbasicos);
            },
            child: Card(
              margin: EdgeInsets.all(10.0),
              color: Colors.red[700],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Center(
                          child: Text("Historial Asistencia",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold)))),
                  Container(
                      padding: EdgeInsets.only(right: 10.0),
                      width: 120.0,
                      height: 120.0,
                      child:
                          Image(image: AssetImage('assets/img/historia.png')))
                ],
              ),
            ),
          ),
        ),

        Container(
          height: alto / 3,
          width: ancho,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'calificaciones',
                  arguments: datosbasicos);
            },
            child: Card(
              margin: EdgeInsets.all(10.0),
              color: Colors.indigoAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Center(
                          child: Text("Notas Finales",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold)))),
                  Container(
                      padding: EdgeInsets.only(right: 10.0),
                      width: 120.0,
                      height: 120.0,
                      child:
                          Image(image: AssetImage('assets/img/calificacion.png')))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
