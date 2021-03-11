import 'package:flutter/material.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';
import 'package:notas/src/models/asistencia_local_model.dart';
import 'package:notas/src/providers/asistencia_provider.dart';

class HistorialAsistencia extends StatefulWidget {
  @override
  _HistorialAsistenciaState createState() => _HistorialAsistenciaState();
}

class _HistorialAsistenciaState extends State<HistorialAsistencia> {
  List<AsisAux> fac = new List<AsisAux>();
  List<Asistencial> asistencias;
  DatosBasicos datosBasicos;
  @override
  Widget build(BuildContext context) {
    datosBasicos = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de Asistencias"),
      ),
      body: _crear(context),
    );
  }

  Widget _crear(BuildContext context) {
    AsistencialProvider ap = AsistencialProvider();
    return FutureBuilder(
      future: ap.getAsistencialIdOfertaPeriodo(datosBasicos.oferta.id,datosBasicos.periodo),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Text('No tienes Historial de asistencias.'),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        asistencias = snapshot.data;
        //listap = snapshot.data;
        if (asistencias.length == 0) {
          return Center(child: CircularProgressIndicator());
        }

        return _crearLista(_crearListaDeFacturas(asistencias));
      },
    );
  }

  Widget _crearLista(List<AsisAux> lista) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (BuildContext context, int index) {
        /*
        return ListTile(
          //leading: Icon(Icons.list),
          //leading: Text(lista[index].a.toString()),
          leading: opcionesAsistencia(index),
          title: Text(lista[index].fecha),
          trailing: Icon(Icons.arrow_forward_ios),
        );
        */
        return elemento(lista[index], index);
      },
    );
  }

  Widget elemento(AsisAux elem, int index) {
    double alto = MediaQuery.of(context).size.height;
    double ancho = MediaQuery.of(context).size.width;
    TextStyle tam2 = TextStyle(fontSize: 20.0);
    return GestureDetector(
      onTap: () => enviar_resumen(elem.fecha),
      child: Card(
        child: Container(
          width: ancho,
          height: alto / 6,
          color: Colors.blue[500],
          child: Row(
            children: [
              Expanded(flex: 1, child: opcionesAsistencia(index)),
              Expanded(
                  flex: 2,
                  child: Text(
                    elem.fecha,
                    style: tam2,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<AsisAux> _crearListaDeFacturas(List<Asistencial> asistencias) {
    fac.clear();
    List<String> fechas = new List<String>();
    asistencias.forEach((element) {
      if (!fechas.contains(element.fecha)) {
        //print('nueva fecha: ' + element.fecha);
        fechas.add(element.fecha);
      }
    });

    fechas.forEach((element) {
      AsisAux aux = new AsisAux();
      aux.fecha = element;

      asistencias.forEach((producto) {
        print("TipoAsistencia: " + producto.tipoAsistencia);
        if (producto.fecha == aux.fecha && producto.tipoAsistencia == 'A') {
          aux.a++;
        }
        if (producto.fecha == aux.fecha && producto.tipoAsistencia == 'F') {
          aux.f++;
        }
        if (producto.fecha == aux.fecha && producto.tipoAsistencia == 'R') {
          aux.r++;
        }
        if (producto.fecha == aux.fecha && producto.tipoAsistencia == 'L') {
          aux.l++;
        }
      });

      fac.add(aux);
    });

    return fac;
  }

  Widget opcionesAsistencia(int index) {
    TextStyle tam = TextStyle(fontSize: 15.0);
    TextStyle tam2 = TextStyle(fontSize: 25.0);
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
                style: tam,
              ),
              Container(
                color: Colors.green,
                child: Text(
                  fac[index].a.toString(),
                  style: tam2,
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
                style: tam,
              ),
              Container(
                color: Colors.red,
                child: Text(
                  fac[index].f.toString(),
                  style: tam2,
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
                style: tam,
              ),
              Container(
                color: Colors.yellow,
                child: Text(
                  fac[index].r.toString(),
                  style: tam2,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "L",
                style: tam,
              ),
              Container(
                color: Colors.deepPurple[400],
                child: Text(
                  fac[index].l.toString(),
                  style: tam2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  enviar_resumen(String fecha) {
    List<Asistencial> aux2 = new List();
    asistencias.forEach((element) {
      if (element.fecha == fecha) {
        aux2.add(element);
      }
    });
     Navigator.pushNamed(context, 'detalle_historial_asistencia',
                  arguments: aux2).then((val) => setState(() => {}));
  }
}

class AsisAux {
  String fecha;
  int a = 0;
  int f = 0;
  int r = 0;
  int l = 0;
}
