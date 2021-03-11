import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';

class Lista_Dimensiones extends StatelessWidget {
  double ancho;
  double alto;
  DatosBasicos datosBasicos;
  @override
  Widget build(BuildContext context) {
    datosBasicos = ModalRoute.of(context).settings.arguments;
    ancho = MediaQuery.of(context).size.width;
    alto = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Dimensiones")),
      body: cargaDimensiones(context),
    );
  }

  Widget cargaDimensiones(BuildContext context) {
    return Column(
      children: <Widget>[
        dimensionSaber(context),
        dimensionHacer(context),
        dimensionSerDecidir(context),
      ],
    );
  }

  Widget dimensionSaber(BuildContext context) {
    String nombre = "SABER";
    return Container(
      height: alto / 4,
      width: ancho,
      child: GestureDetector(
        onTap: () {
          setArea(2, nombre);
          Navigator.pushNamed(context, 'lista_criterios',
              arguments: datosBasicos);
        },
        child: Card(
          color: Colors.grey[700],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    nombre + ' ( 45 )',
                    style: GoogleFonts.poiretOne(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.white),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(right: 15.0),
                  width: 100.0,
                  height: 100.0,
                  child: Image(
                    image: AssetImage("assets/img/saber.png"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget dimensionHacer(BuildContext context) {
    String nombre = "HACER";
    return Container(
      height: alto / 4,
      width: ancho,
      child: GestureDetector(
        onTap: () {
          setArea(3, nombre);
          Navigator.pushNamed(context, 'lista_criterios',
              arguments: datosBasicos);
        },
        child: Card(
          color: Colors.deepPurple,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    nombre + ' ( 45 )',
                    style: GoogleFonts.poiretOne(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15.0),
                width: 100.0,
                height: 100.0,
                child: Image(
                  image: AssetImage("assets/img/hacer.png"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget dimensionSerDecidir(BuildContext context) {
    String nombre = "SER-DECIDIR";
    return Container(
      height: alto / 4,
      width: ancho,
      child: GestureDetector(
        onTap: () {
          setArea(1, nombre);
          Navigator.pushNamed(context, 'lista_criterios',
              arguments: datosBasicos);
        },
        child: Card(
          color: Colors.indigo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    nombre + ' ( 10 )',
                    style: GoogleFonts.poiretOne(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15.0),
                width: 100.0,
                height: 100.0,
                child: Image(
                  image: AssetImage("assets/img/ser.png"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setArea(int a, String nombre) {
    datosBasicos.area.setArea(a);
    datosBasicos.area.nombre = nombre;
  }
}
