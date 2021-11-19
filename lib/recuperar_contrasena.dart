import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'home.dart';
import 'login.dart';

class RecuperarContrasena extends StatefulWidget {
  static const String ROUTE = "/recuperarcontrasena";
  @override
  _RecuperarContrasenaState createState() => _RecuperarContrasenaState();
}

class _RecuperarContrasenaState extends State<RecuperarContrasena> {
  TextEditingController correocontroler = TextEditingController();
  TextEditingController contrasenacontroller = TextEditingController();
  TextEditingController contrasenanuevacontroller = TextEditingController();
  bool verificacion = false;
  List datosusu;
  @override
  void initState() {
    validarCorreo().then((value) {
      datosusu = value;
      setState(() {
        print(datosusu);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: ListView(
            children: [
              Text("Ingrese el correo electronico asociado a su cuenta:"),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: correocontroler,
                decoration: InputDecoration(hintText: "Ingrese su correo"),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await validarCorreo();
                    validarCorreo().then((value) {
                      datosusu = value;

                      setState(() {});
                    });
                    if (correocontroler.text == "") {
                      Fluttertoast.showToast(
                          msg: "ingrese un correo por favor ");
                    } else if (datosusu[0]['Usuario_correo'] == null) {
                      Fluttertoast.showToast(
                          msg:
                              "no se ha encontrado ningun correo en nuestra base de datos");
                    } else {
                      verificacion = true;
                      setState(() {});
                    }
                  },
                  child: Text("validar correo")),
              Visibility(
                child: Container(
                  child: ListBody(
                    children: [
                      TextFormField(
                        controller: contrasenacontroller,
                        decoration: const InputDecoration(
                          labelText: "ingrese su nueva contraseña",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextFormField(
                        controller: contrasenanuevacontroller,
                        decoration: const InputDecoration(
                          labelText: "confirme su nueva contraseña",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            editarUsuario();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text("cambiar contraseña"))
                    ],
                  ),
                ),
                visible: verificacion,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List> validarCorreo() async {
    var correo = correocontroler.text;
    var url =
        "http://192.168.1.81/pruebastesis/validarCorreo.php?Usuario_correo=$correo";
    final response = await http.get(Uri.parse(url));
    final datauser = jsonDecode(response.body);

    return datauser;
  }

  Future editarUsuario() async {
    var correo = correocontroler.text;

    var url =
        "http://192.168.1.81/pruebastesis/recuperarContrasena?Usuario_correo=$correo";
    await http.post(Uri.parse(url), body: {
      'Usuario_contrasena': contrasenacontroller.text,
    });
    return true;
  }
}
