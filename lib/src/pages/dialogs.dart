import 'package:flutter/material.dart';
class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }

  static exito(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Guardado con Exito"),
              content: Container(
                height: 100,
                width: 100,
                child: Image(image: AssetImage("assets/img/success.gif"))
                ),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  static fallo(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("No se pudieron guardar los datos!"),
              content: Container(
                height: 100,
                width: 100,
                child: Image(image: AssetImage("assets/img/fail.gif"))
                ),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}