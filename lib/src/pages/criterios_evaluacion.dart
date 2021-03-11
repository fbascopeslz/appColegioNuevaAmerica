import 'package:flutter/material.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';
import 'package:notas/src/models/actividad_model.dart';
import 'package:notas/src/providers/actividad_provider.dart';

import 'package:intl/intl.dart';
import 'package:notas/src/utils/mensajes.dart';

class ListaCriterios extends StatefulWidget {
  @override
  _ListaCriteriosState createState() => _ListaCriteriosState();
}

class _ListaCriteriosState extends State<ListaCriterios> {
  DatosBasicos datosBasicos;
  ActividadesProvider pa = new ActividadesProvider();
  TextEditingController _inputdate = new TextEditingController();

  DateTime fecha;
  @override
  Widget build(BuildContext context) {
    datosBasicos = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(datosBasicos.area.nombre),
      ),
      body: cargarActividades(),
      floatingActionButton: botonFlotante(context),
    );
  }

  Widget botonFlotante(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        crearActividad(context);
      },
      child: Icon(Icons.add),
    );
  }

  Future crearActividad(BuildContext context) async{
    String _nuevaActividad = '';
    return showDialog(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nombre nueva actividad'),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Nombre actividad' /*, hintText: 'Nombre'*/),
                onChanged: (value) {
                  _nuevaActividad = value;
                },
              ),
              _crearFecha(),
            ],
          ),
          actions: [
            FlatButton(
              child: Text('Crear'),
              onPressed: () async{
                Actividad db = new Actividad();

                datosBasicos.actividad.indicador = _nuevaActividad;
                /*
                DateTime now = new DateTime.now();
                var formatter = new DateFormat('yyyy-MM-dd');
                datosBasicos.actividad.fecha =
                    DateTime(now.year, now.month, now.day);
                */
                db = datosBasicos.actividad;
                var formatter = new DateFormat('yyyy-MM-dd');
                String fecha2 = formatter.format(fecha);
                print(datosBasicos.periodo);
                await pa.setActividad(db.indicador, fecha2, db.area.id, datosBasicos.oferta.id,datosBasicos.periodo);
                if (fecha2 == "" || _nuevaActividad == "") {
                  String mensaje = 'Ambos campos deben rellenarse!';
                  MostrarMensaje(mensaje, context);
                } else {
                  Navigator.pop(context);
                  setState(() {
                    
                  });
                }
              },
            ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget cargarActividades() {
    return FutureBuilder(
      future: pa.getActividades(datosBasicos.oferta.id, datosBasicos.area.id,datosBasicos.periodo),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final actividades = snapshot.data;

        if (actividades.length == 0) {
          return Center(
            child: Text('No Tienes Actividades registradas.'),
          );
        }

        return _crearLista(actividades, context);
      },
    );
  }

  Widget _crearLista(List<Actividad> la, BuildContext context) {
    return ListView.builder(
      itemCount: la.length,
      itemBuilder: (BuildContext context, int index) {
        var now = DateTime.parse(la[index].fecha.toString());
        var formatter = new DateFormat('dd-MM-yyyy');
        String formatted = formatter.format(now);

        return Column(
          children: [
            ListTile(
              title: Text(la[index].indicador),
              subtitle: Text(formatted),
              //leading: Image(image: AssetImage("assets/img/noimage.png")),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                datosBasicos.actividad.id = la[index].id;
                datosBasicos.actividad.indicador = la[index].indicador;
                Navigator.pushNamed(context, 'calificar_alumnos',
                    arguments: datosBasicos);
              },
            ),
            Divider(
              color: Colors.green,
            ),
          ],
        );
      },
    );
  }

  Widget _crearFecha() {
    return TextField(
      controller: _inputdate,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        labelText: 'Fecha',
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    var formatter = new DateFormat('dd-MM-yyyy');

    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(DateTime.now().year - 1),
        lastDate: new DateTime(DateTime.now().year + 1),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        fecha = picked;
        String fecha2 = formatter.format(DateTime.parse(picked.toString()));
        _inputdate.text = fecha2;
      });
    }
  }
}
