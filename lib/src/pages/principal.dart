import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';
import 'package:notas/src/models/oferta_model.dart';
import 'package:notas/src/pages/login.dart';
import 'package:notas/src/providers/oferta_providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:notas/src/providers/profesor_provider.dart';
import 'package:notas/src/utils/materia_utils.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  DatosBasicos datosbasicos;

  List<bool> periodoCheck = [true, false, false];

  List<bool> gestionCheck = [true, false];

  @override
  Widget build(BuildContext context) {
    datosbasicos = ModalRoute.of(context).settings.arguments;
    if (datosbasicos.periodo == null) {
      datosbasicos.periodo = 1;
    }
    
      datosbasicos.gestion=2020;
    

    return WillPopScope(
      onWillPop: () async => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: Text('Esta seguro que quiere salir?'),
                  actions: <Widget>[
                    RaisedButton(
                        child: Text('Salir'), onPressed: () => exit(0)),
                    RaisedButton(
                        child: Text('Cancelar'),
                        onPressed: () => Navigator.of(context).pop(false)),
                    RaisedButton(
                        child: Text('Cerrar seccion'),
                        onPressed: () => Navigator.of(context)
                            .pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (Route<dynamic> route) => false)),
                  ])),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry>[
                  CheckedPopupMenuItem(
                    child: Text("PRIMER TRIMESTRE"),
                    value: 1,
                    checked: periodoCheck[0],
                  ),
                  CheckedPopupMenuItem(
                    child: Text("SEGUNDO TRIMESTRE"),
                    value: 2,
                    checked: periodoCheck[1],
                  ),
                  CheckedPopupMenuItem(
                    child: Text("TERCER TRIMESTRE"),
                    value: 3,
                    checked: periodoCheck[2],
                  ),
                  PopupMenuDivider(
                    height: 10,
                  ),
                  CheckedPopupMenuItem(
                    child: Text("2020"),
                    value: 6,
                    checked: gestionCheck[0],
                  ),
                  CheckedPopupMenuItem(
                    child: Text("2021"),
                    value: 7,
                    checked: gestionCheck[1],
                  ),
                ];
              },
              onSelected: (value) {
                configValues(value);
                setState(() {});
              },
            )
          ],
          title: Text('Tus Materias'),
        ),
        body: getProfesor(context),
      ),
    );
  }

  configValues(int value) {
    switch (value) {
      case 1:
        periodoCheck[0] = true;
        periodoCheck[1] = false;
        periodoCheck[2] = false;
        datosbasicos.periodo = 1;
        break;
      case 2:
        periodoCheck[0] = false;
        periodoCheck[1] = true;
        periodoCheck[2] = false;
        datosbasicos.periodo = 2;
        break;
      case 3:
        periodoCheck[0] = false;
        periodoCheck[1] = false;
        periodoCheck[2] = true;
        datosbasicos.periodo = 3;
        break;
      case 6:
        gestionCheck[0] = true;
        gestionCheck[1] = false;
        datosbasicos.gestion = 2020;
        break;
      case 7:
        gestionCheck[0] = false;
        gestionCheck[1] = true;
        datosbasicos.gestion = 2021;
        break;
    }
  }

  Widget getProfesor(BuildContext context) {
    final ProfesoresProvider pf = new ProfesoresProvider();
    return FutureBuilder(
      future: pf.getProfesorXIdUsuario(datosbasicos.idUsuario),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return prueba(snapshot.data, context);
      },
    );
  }

  Widget prueba(int idprofesor, BuildContext context) {
    final ofertasProvider = new OfertasProvider();

    return FutureBuilder(
      future: ofertasProvider.getOfertas(idprofesor),
      initialData: null,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final ofertas = snapshot.data;

        if (ofertas.length == 0) {
          return Center(
            child: Text('No Tienes materias asignadas.'),
          );
        }

        return _crearLista(ofertas, context);
      },
    );
  }

  Widget _crearLista(List<Oferta> ofertas, BuildContext context) {
    double alto = MediaQuery.of(context).size.height;
    double ancho = MediaQuery.of(context).size.width;
    String curso = '';

    return ListView.builder(
        itemCount: ofertas.length,
        itemBuilder: (BuildContext context, int index) {
          if (ofertas[index].cursoParalelo.curso.nivel.nombre ==
              "PRIMARIA COMUNITARIA VOCACIONAL") {
            curso = "(PRIMARIA)";
          } else {
            curso = "(SECUNDARIA)";
          }
          return Container(
            height: alto / 3,
            padding: EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                datosbasicos.oferta = ofertas[index];
                Navigator.pushNamed(context, 'materia',
                    arguments: datosbasicos);
              },
              child: Card(
                color: getColorMateria(ofertas[index].materia.id),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 1.0,
                                maxWidth: (ancho / 4) * 2,
                                minHeight: 1.0,
                                maxHeight: alto / 3,
                              ),
                              child: AutoSizeText(
                                ofertas[index].materia.nombre,
                                style: GoogleFonts.poiretOne(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21.0,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Text(
                            ofertas[index]
                                    .cursoParalelo
                                    .curso
                                    .nombrenum
                                    .toString() +
                                ofertas[index].cursoParalelo.paralelo.nombre +
                                curso,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 20.0),
                        width: 120.0,
                        height: 110.0,
                        child: ClipRRect(
                          //borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            //color: Colors.white,
                            child: Image(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/img/Iconos-Materia/' +
                                    ofertas[index].materia.id.toString() +
                                    '.png')),
                          ),
                        )),
                  ],
                ),
                elevation: 10.0,
              ),
            ),
          );
        });
  }
}
