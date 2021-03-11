import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

MostrarMensaje(String mensaje, BuildContext context, [String titulo="Mensaje"]) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(titulo),
    content: Text(mensaje),
    actions: [
      okButton,
    ],
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
