import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:notas/src/models/DatosBasicos_model.dart';
import 'package:notas/src/models/usuario_model.dart';
import 'package:notas/src/providers/usuario_provider.dart';

const users = const {
  '111': '111',
  '222': '222',
  'prof1@gmail.com': '111',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  DatosBasicos datosbasicos = new DatosBasicos();

  Future<String> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    UsuariosProvider up = new UsuariosProvider();
    String md = md5.convert(utf8.encode(data.password)).toString();
    //String md = data.password;

    List<Usuario> usu = await up.getUsuario(data.name, md);

    if (usu.length > 0) {
      datosbasicos.idUsuario = usu[0].id;
      return null;
      //return "Logeo exitoso!";
    } else {
      return "Datos incorrectos, verifique los datos.";
    }
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(Duration(seconds: 1)).then((_) {
      if (!users.containsKey(name)) {
        return 'El usuario no existe';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    datosbasicos.DatosBasicos2();
    return FlutterLogin(
      messages: LoginMessages(
        usernameHint: 'Usuario',
        passwordHint: 'contrasena',
        loginButton: 'Ingresar',
        signupButton: 'Registrar',
        forgotPasswordButton: 'Olvidaste tu contrasena?',
      ),
      emailValidator: (str) {
        if (str == "") {
          return "Debes ingresar un usuario!";
        } else {
          return null;
        }
      },
      passwordValidator: (value) {
        return null;
      },
      title: '',
      logo: 'assets/img/logo.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        /*
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Principal(),
        ));
        */
        Navigator.pushNamed(context, 'principal', arguments: datosbasicos);
      },
      onRecoverPassword: _recoverPassword,
    );
  }

  void salida(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text('Esta seguro que quiere cerrar sesión?'),
                actions: <Widget>[
                  RaisedButton(
                      color: Colors.blue,
                      child: Text('Si'),
                      onPressed: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('login'));
                        Navigator.pushNamed(context, 'login');
                      }),
                  RaisedButton(
                      color: Colors.red,
                      child: Text('No'),
                      onPressed: () => Navigator.of(context).pop(false)),
                ]));
  }
}
