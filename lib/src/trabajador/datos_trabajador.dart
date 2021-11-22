import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class DatosTrabajador extends StatefulWidget {
  static const String ROUTE = "/datostrabajador";
  final String id;

  const DatosTrabajador({Key key, this.id}) : super(key: key);

  @override
  _DatosTrabajadorState createState() => _DatosTrabajadorState();
}

class _DatosTrabajadorState extends State<DatosTrabajador> {
  Future<List> obtenerUsuarios() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://152.173.193.119/pruebastesis/obtenerDatos.php?Usuarioid=$id";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("login");
            },
            child: Text("Salir"),
          )
        ],
      ),
      body: FutureBuilder<dynamic>(
        future: obtenerUsuarios(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ElementoLista(
                  lista: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
      bottomNavigationBar: TrabajadorBottomBar('datostrabajador'),
    );
  }
}

class ElementoLista extends StatelessWidget {
  final List lista;
  final foto = ImagePicker();
  File fotoi;

  ElementoLista({this.lista});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lista == null ? 0 : lista.length,
      itemBuilder: (context, posicion) {
        var fotousu = lista[posicion]['Usuario_foto'].toString();
        return Container(
          padding: EdgeInsets.all(2.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 25.0,
                ),
                Title(
                    color: Colors.white,
                    child: Text(
                      "DATOS PERSONALES",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    )),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  width: 250,
                  height: 250,
                  child: lista[posicion]['Usuario_foto'] != null
                      ? Image.network(
                          "http://152.173.193.119/lefufuapp/public/uploads/trabajadores/$fotousu",
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          "assets/no_user.png",
                          fit: BoxFit.fill,
                        ),
                ),
                ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      "Nombre: " "" + lista[posicion]['Usuario_nombre'],
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      "Correo: " "" + lista[posicion]['Usuario_correo'],
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(
                      "Direccion: " "" + lista[posicion]['Usuario_direccion'],
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      "Telefono: " "" + lista[posicion]['Usuario_telefono'],
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _mostrarFoto() {
    if (fotoi == null) {
      return SizedBox(
        height: 250,
        width: 250,
        child: Image.asset("assets/no-image.png"),
      );
    } else {
      return SizedBox(
        child: fotoi != null
            ? Image.file(fotoi)
            : Fluttertoast.showToast(msg: "por favor seleccione una imagen"),
        height: 300,
        width: 300,
      );
    }
  }
}
