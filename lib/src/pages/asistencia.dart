import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';
import 'package:notas/src/models/asistencia_local_model.dart';
import 'package:notas/src/models/asistencia_model.dart';
import 'package:notas/src/models/inscripcion_model.dart';
import 'package:notas/src/providers/asistencia_provider.dart';
import 'package:notas/src/providers/inscripciones_provider.dart';
import 'package:notas/src/utils/mensajes.dart';
import 'dialogs.dart';
import 'package:http/http.dart' as http;
import 'dart:math';


class Asistencia extends StatefulWidget {  
  @override
  _AsistenciaState createState() => _AsistenciaState();
}

class _AsistenciaState extends State<Asistencia> {
  bool banderalista = false;
  List<List<bool>> lista = new List();
  List<String> eleccion = new List();
  List<Asistencial> asis = new List();
  List<Inscripcion> alumnos = new List();

  DatosBasicos datosBasicos;


  //image_picker
  File imageFile;
  bool isImageLoaded = false;

  //Visión de Firebase 
  FirebaseVisionImage visionImage;

  List<AsistenciaModelo> listaAsistencia = new List();

  Random rnd = new Random();
  


  @override
  Widget build(BuildContext context) {
    datosBasicos = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0)
            ),
            //padding: EdgeInsets.all(4.0),
            child: IconButton(
              icon: Image.asset("assets/img/icons/save.png"),
              onPressed: () => verificarCampos()
            )
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0)
            ),
            //padding: EdgeInsets.all(4.0),
            child: IconButton(
              icon: Image.asset("assets/img/icons/camera.png"),
              onPressed: () => elegirTipoTomaAsistencia()
            )
          ),
        ],
        title: Text('Asistencia'),
      ),
      body: cargarAlumnos(),
    );
  }




  void elegirTipoTomaAsistencia() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccione una opcion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: tomarAsistenciaConFoto,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera, size: 36.0, color: Colors.blue),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 16.0),
                        child: Text("Camara"),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: tomarAsistenciaConArchivo,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,                    
                    children: [
                      Icon(Icons.file_copy, size: 36.0, color: Colors.blue),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 16.0),
                        child: Text("Archivo"),
                      ),
                    ],
                  ),
                ),                
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> tomarAsistenciaConFoto() async {
    Navigator.of(context).pop();
    
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    
    if (picture != null) {
      this.setState((){
        this.imageFile = picture;
        isImageLoaded = true;

        dialogConfirmacionImagen();

      });
    }
  }

  Future<void> tomarAsistenciaConArchivo() async {
    Navigator.of(context).pop();
    
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
      
    if (picture != null) {
      this.setState((){
        this.imageFile = picture;
        isImageLoaded = true;

        dialogConfirmacionImagen();

      });
    }      
  }

  void dialogConfirmacionImagen() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmacion de imagen'),
          content: SingleChildScrollView(        
            child: Column(              
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,                
              children: <Widget>[
                Image.file(this.imageFile),                 
                          
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {                                                                  
                Navigator.of(context).pop();                
                reconocerCarasEnImagen();
              },
              child: Text('ACEPTAR')
            ),
            FlatButton(
              onPressed: () {                                                                  
                Navigator.of(context).pop();                                
              },
              child: Text('CANCELAR')
            ),                      
          ],
        );
      }
    );
  }

  Future<void> reconocerCarasEnImagen() async {
    visionImage = FirebaseVisionImage.fromFile(imageFile);
    final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator(),);
      }
    );          
    final List<Face> faces = await faceDetector.processImage(visionImage);
    Navigator.pop(context);

    print("NUMERO DE CARAS: ---------------- " + faces.length.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Imagen analizada correctamente'),
          content: Text("El numero de rostros detectados fue: " + faces.length.toString()),
          actions: <Widget>[            
            FlatButton(
              onPressed: () {
                marcarCasillasAsistencia(faces.length);                                                                  
                Navigator.of(context).pop();                                
              },
              child: Text('ACEPTAR')
            ),                      
          ],
        );
      }
    );

  }

  void marcarCasillasAsistencia(int numeroCaras) {
    //resetear las listas de estados
    resetearListas();

    if (numeroCaras >= alumnos.length) {
      //numeroCaras = alumnos.length;
      //marcar todos con asistencia
      for (var i = 0; i < lista.length; i++) {        
        setState(() {
          lista[i][0] = true;
          lista[i][1] = false;
          lista[i][2] = false;
          lista[i][3] = false;
          eleccion[i] = "A";
        });                         
      }
    } else {
      int min = 0, max = alumnos.length - 1;
      int r = 0;
      //marcar aleatorio con Asistencia
      int marcados = 0;
      while(marcados < numeroCaras) {
        //index aleatorio de la lista de estudiantes
        r = min + rnd.nextInt(max - min);
        if (!lista[r][0] == true) {
          setState(() {
            lista[r][0] = true;
            lista[r][1] = false;
            lista[r][2] = false;
            lista[r][3] = false;
            eleccion[r] = "A";
          });
          marcados++;
        }
      }    
      //marcar los demas con Falta
      for (var i = 0; i < lista.length; i++) {
        List<bool> aux = lista[i];       
        if (!aux[0] == true) {
          setState(() {
            lista[i][0] = false;
            lista[i][1] = true;
            lista[i][2] = false;
            lista[i][3] = false;
            eleccion[i] = "F";
          });
        }                 
      }
    }


  }

  void resetearListas() {    
    for (var i = 0; i < lista.length; i++) {                 
      setState(() {
        lista[i][0] = false;
        lista[i][1] = false;
        lista[i][2] = false;
        lista[i][3] = false;        
        eleccion[i] = "";
      });                       
    }    
  }

  Future<void> registrarAsistencia() async {
    String resp = "";   

    for (var i = 0; i < alumnos.length; i++) {
      AsistenciaModelo asistencia = new AsistenciaModelo();
      switch (eleccion[i]) {
        case "A":
          asistencia.idTipoAsistencia = 1;
          break;
        case "F":
          asistencia.idTipoAsistencia = 2;
        break;
        case "R":
          asistencia.idTipoAsistencia = 3;
          break;
        case "L":
          asistencia.idTipoAsistencia = 4;
          break;
        default:
      }      
      asistencia.idOferta = datosBasicos.oferta.id;
      asistencia.idAlumno = alumnos[i].alumno.id;
      asistencia.idPeriodo = datosBasicos.periodo;
      listaAsistencia.add(asistencia);
    }
    
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({"listaAsistencia": json.encode(listaAsistencia)});

    final response = await http.post(
      //url del servicio
      "http://www.saparicio.xyz/api/asistencia/registrarAsistencia",
      headers: headers,
      body: body
    );

    resp = response.statusCode.toString();

    var respuesta = json.decode(response.body);
    print(respuesta.toString());
    //MostrarMensaje(respuesta.toString(), context);
    
    if (resp == "200") {
      await Dialogs.exito(context);
      Navigator.pop(context);
    } else {
      Dialogs.fallo(context);
    }
  
  }

  



  Widget cargarAlumnos() {
    InscripcionessProvider pa = new InscripcionessProvider();

    return FutureBuilder(
      future: pa.getAlumnos(
        datosBasicos.oferta.cursoParalelo.id, 
        datosBasicos.gestion
      ),
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

        alumnos = snapshot.data;
        if (!banderalista) {
          //int nume = 0;
          alumnos.forEach((element) {
            //print("creando..." + nume.toString());
            //nume++;
            print("creando ALUMNO..........." + element.alumno.id.toString());
            crearListaEstados();
          });
          banderalista = true;
        }

        if (alumnos.length == 0) {
          return Center(
            child: Text('No Tienes alumnos asignados.'),
          );
        }
        return _crearLista(alumnos, context);
      },
    );
  }

  void crearListaEstados() {
    bool a = false;
    bool f = false;
    bool r = false;
    bool l = false;
    List<bool> l1 = new List();
    l1 = [a, f, r, l];
    lista.add(l1);
    eleccion.add("");
  }

  Widget _crearLista(List<Inscripcion> la, BuildContext context) {
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
                        maxWidth: (ancho / 6) * 2.0,
                        minHeight: 1.0,
                        maxHeight: alto / 3,
                      ),
                      child: AutoSizeText(
                        '${index + 1}. ' + la[index].alumno.nombre,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3, 
                    child: opcionesAsistencia(index, la.length)
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget opcionesAsistencia(int index, int total) {
    
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
                      eleccion[index] = "A";
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
                      eleccion[index] = "F";
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
                      eleccion[index] = "R";
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
                      eleccion[index] = "L";
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

  bool bandera2 = false;
  bool banderaverf = true;

  void verificarCampos() {
    //print(asis);
    banderaverf = true;
    
    lista.forEach((element) {
      bandera2 = false;
      element.forEach((element2) {
        if (element2) {
          bandera2 = true;
        }
      });
      if (!bandera2) {
        banderaverf = false;
        return;
      }
    });

    if (banderaverf) {
      //print("se guarda");
      //guardarAsistencia();
      registrarAsistencia();
    } else {
      String mensaje = "Todos los campos deben estar rellenados!";
      MostrarMensaje(mensaje, context);
    }
  }

  Future<void> guardarAsistencia() async {
    String resp = "";
    Asistencial aux = new Asistencial();
    AsistencialProvider ap = AsistencialProvider();
    int num = 0;
    alumnos.forEach((element) {
      Asistencial aux = new Asistencial();
      aux.alumnoid = element.alumno.id;
      aux.ofertaid = datosBasicos.oferta.id;
      aux.nombreAlumno = element.alumno.nombre;
      aux.periodoid = datosBasicos.periodo;
      aux.tipoAsistencia = eleccion[num];
      asis.add(aux);
      num++;
    });

    try {
      //Dialogs.showLoadingDialog(context, _keyLoader); //invoking login
      var fecha = DateFormat("yyyy-MM-dd H:mm:ss").format(DateTime.now()).toString();
      asis.forEach((element) async {
        element.fecha = fecha;
        var salida = await ap.insert(element);
        print("respuesta asistencia:" + salida.toString());
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
