import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notas/src/pages/alumno.dart';
import 'package:notas/src/pages/asistencia.dart';
import 'package:notas/src/pages/asitencia_editar.dart';
import 'package:notas/src/pages/calificacion.dart';
import 'package:notas/src/pages/calificar_alumno.dart';
import 'package:notas/src/pages/criterios_evaluacion.dart';
import 'package:notas/src/pages/detalle_historial_asistencia.dart';
import 'package:notas/src/pages/historial_asistencia.dart';
import 'package:notas/src/pages/lista_alumnos.dart';
import 'package:notas/src/pages/lista_dimensiones.dart';
import 'package:notas/src/pages/login.dart';
import 'package:notas/src/pages/materia.dart';
import 'package:notas/src/pages/principal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: GoogleFonts.poiretOne(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                    color: Colors.white),
          )
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English, no country code
          const Locale('es', 'ES'),
        ],
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Material App Bar'),
          ),
          body: Center(
            child: Container(
              child: Text('vista1'),
            ),
          ),
        ),
        initialRoute: 'login',
        routes: <String, WidgetBuilder>{
          'login': (BuildContext context) => LoginScreen(),
          'principal': (BuildContext context) => Principal(),
          'materia': (BuildContext context) => MateriaView(),
          'lista_dimensiones': (BuildContext context) => Lista_Dimensiones(),
          'lista_criterios': (BuildContext context) => ListaCriterios(),
          'lista_alumnos': (BuildContext context) => ListaAlumnos(),
          'calificar_alumnos': (BuildContext context) => CalificarAlumno(),
          'alumno_page': (BuildContext context) => AlumnoPage(),
          'asistencia': (BuildContext context) => Asistencia(),
          'historial_asistencia': (BuildContext context) => HistorialAsistencia(),
          'detalle_historial_asistencia': (BuildContext context) => DetalleHistorialAsistencia(),
          'editar_asistencia': (BuildContext context) => EditarAsistencia(),
          'calificaciones': (BuildContext context) => Calificaciones(),
        });
  }
}
