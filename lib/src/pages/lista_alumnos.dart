import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';
import 'package:notas/src/models/inscripcion_model.dart';
import 'package:notas/src/providers/bd.dart';
import 'package:notas/src/providers/inscripciones_provider.dart';

class ListaAlumnos extends StatefulWidget {
  @override
  _ListaAlumnosState createState() => _ListaAlumnosState();
}

class _ListaAlumnosState extends State<ListaAlumnos> {
  DatosBasicos datosBasicos;

  @override
  Widget build(BuildContext context) {
    datosBasicos = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista Alumnos"),
      ),
      body: cargarAlumnos(),
    );
  }

  Widget cargarAlumnos() {
    InscripcionessProvider pa = new InscripcionessProvider();

    return FutureBuilder(
      future: pa.getAlumnos(
          datosBasicos.oferta.cursoParalelo.id, datosBasicos.gestion),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final alumnos = snapshot.data;

        if (alumnos.length == 0) {
          return Center(
            child: Text('No Tienes alumnos asignados.'),
          );
        }

        return _crearLista(alumnos, context);
      },
    );
  }

  Widget _crearLista(List<Inscripcion> la, BuildContext context) {
    BD bd = BD();
    String _url = "https://" + bd.url + "/api/images";
    double alto = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: la.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: alto / 5,
          child: Card(
            margin: EdgeInsets.all(5.0),
            color: generarRGB(),
            child: Center(
              child: ListTile(
                onTap: () {
                  datosBasicos.idInscripcion = la[index].id;
                  datosBasicos.alumno = la[index].alumno;
                  Navigator.pushNamed(context, 'alumno_page',
                      arguments: datosBasicos).then((val) => setState(() => {}));
                },
                title: Text(
                  '${index + 1}. ' + la[index].alumno.nombre,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FadeInImage(
                        placeholder: AssetImage("assets/img/noimage.png"),
                        image:la[index].alumno.fotografia != null? NetworkImage(
                            "$_url/${la[index].alumno.fotografia}"+"?thumbnail=true"): AssetImage("assets/img/noimage.png"))),
                //child: Image(image: AssetImage("assets/img/noimage.png"))),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        );
      },
    );
  }

  Color generarRGB() {
    Random random = new Random();
    int r = random.nextInt(255) + 100;
    int g = random.nextInt(150) + 10;
    int b = random.nextInt(100) + 10;
    return Color.fromRGBO(r, g, b, 1);
  }
}
