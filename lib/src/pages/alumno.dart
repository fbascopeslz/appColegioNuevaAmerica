import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';
import 'package:notas/src/pages/resumen_asistencia.dart';
import 'package:notas/src/pages/resumen_notas.dart';
import 'package:notas/src/providers/alumnos_provider.dart';
import 'package:notas/src/providers/bd.dart';

class AlumnoPage extends StatefulWidget {
  @override
  _AlumnoPageState createState() => _AlumnoPageState();
}

class _AlumnoPageState extends State<AlumnoPage> {
  DatosBasicos datosBasicos;
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    print(_image);
    datosBasicos = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(datosBasicos.alumno.nombre),
      ),
      body: ListView(
        children: [
          fotoAlumno(),
          Divider(height: 20.0,color: Colors.blue),
          tarjetaAlumno(),
          Divider(height: 20.0,color: Colors.blue),
          resumenNotas(datosBasicos, context),
          Divider(height: 20.0,color: Colors.blue),
          resumenAsistencia(datosBasicos, context),
        ],
      ),
    );
  }

  Widget fotoAlumno() {
    BD bd = BD();
    String _url = "https://" + bd.url + "/api/images/";
    //double alto = MediaQuery.of(context).size.height;
    double ancho = MediaQuery.of(context).size.width;
    return Stack(children: <Widget>[
      Container(
        width: ancho,
        height: ancho,
        child: FadeInImage(
          placeholder: _image == null
              ? AssetImage("assets/img/noimage.png")
              : FileImage(_image),
          image: (datosBasicos.alumno.fotografia != null ? NetworkImage("$_url${datosBasicos.alumno.fotografia}"):AssetImage("assets/img/noimage.png")),
          fit: BoxFit.cover,
        ),
      ),
      Container(
        alignment: Alignment.bottomRight,
        child: IconButton(
            icon: Icon(Icons.image),
            onPressed: () => _cargarFoto(ImageSource.gallery)),
      ),
      Container(
        padding: EdgeInsets.only(right: 30.0),
        alignment: Alignment.bottomRight,
        child: IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => _cargarFoto(ImageSource.camera)),
      ),
    ]);
  }

  Future _cargarFoto(ImageSource imgsource) async {
    final pickedFile = await picker.getImage(source: imgsource);
    if (pickedFile != null) {
      _image = await cropImage(File(pickedFile.path));
      //_image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    setState(() {
      subirFoto();
    });
  }

  Future subirFoto() async {
    BD bd = BD();
    String _url = "https://" + bd.url + "/api/images";
    print("url para subir imagen:" + _url);
    final url = Uri.parse(_url);
    final mimeTipe = mime(_image.path).split('/');
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', _image.path,
        contentType: MediaType(mimeTipe[0], mimeTipe[1]));
    imageUploadRequest.files.add(file);

    final response = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(response);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    print('nombre_generado: ' + respData['fileName']);
    actualizarCampoFotografia(respData['fileName']);
    return respData['fileName'];
  }

  Future actualizarCampoFotografia(String fotografia) async {
    AlumnosProvider ap = new AlumnosProvider();
    datosBasicos.alumno.fotografia = fotografia;
    await ap.updateAlumno(datosBasicos.alumno);
    print("fotografia subida hasta aqui!");
  }

  Future<File> cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 512,
      maxHeight: 512,
    );
    return croppedFile;
  }

  Widget tarjetaAlumno() {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      color: Colors.green[400],
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.person),
              SizedBox(
                width: 20.0,
              ),
              Text(datosBasicos.alumno.nombre),
            ],
          ),
          Row(
            children: [
              Icon(Icons.place),
              SizedBox(
                width: 20.0,
              ),
              Text(datosBasicos.alumno.direccion),
            ],
          ),
          Row(
            children: [
              Icon(Icons.mail),
              SizedBox(
                width: 20.0,
              ),
              Text(datosBasicos.alumno.email),
            ],
          ),
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(
                width: 20.0,
              ),
              Text(datosBasicos.alumno.telefono),
            ],
          ),
        ],
      ),
    );
  }
}
