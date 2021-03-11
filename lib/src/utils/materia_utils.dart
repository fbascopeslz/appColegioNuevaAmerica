import 'package:flutter/material.dart';

Color getColorMateria(int materia) {
  Map mapa = {
    1: Colors.green[700], // CIENCIAS NATURALES:BIOLOGIA
    2: Colors.red[700],   //FISICA
    3: Colors.blue[800],  //QUIMICA
    4: Colors.blueGrey,   //LENGUA CASTELLANA Y ORIGINARIA
    5: Colors.lightBlue,  //LENGUA EXTRANJERA
    6: Colors.redAccent,  //CIENCIAS SOCIALES
    7: Colors.indigo,     //HISTORIA
    8: Colors.lime,       //GEOGRAFIA
    9: Colors.purple,     //EDUCACION CIVICA
    10: Colors.purpleAccent,      //ARTES PLASTICAS Y VISUALES
    11: Colors.orange,            //EDUCACION MUSICAL
    12: Colors.teal,              //COSMOVISIONES Y FILOSOFIA
    13: Colors.tealAccent,        //PSICOLOGIA
    14: Colors.yellow,            //VALORES, ESPIRITUALIDAD Y RELIGIONES
    15: Colors.deepPurpleAccent,  //MATEMATICAS
    16: Colors.cyan[800],         //TECNICA TECNOLOGICA
    17: Colors.brown[800],        //MATEMATICAS
    18: Colors.amber,             //CIENCIAS NATURALES
    19: Colors.amberAccent,       //LENGUA CASTELLANA, ORIGINARIA Y EXTRANJERA
    20: Colors.lightGreenAccent   //EDUCACION FISICA Y DEPORTES
  };

  return mapa[materia];
}
