import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'dart:async';

class DatosEmpresa extends StatefulWidget {
  static const String ROUTE = "/datosempresa";
  final String id;

  const DatosEmpresa({Key key, this.id}) : super(key: key);

  @override
  _DatosEmpresaState createState() => _DatosEmpresaState();
}

class _DatosEmpresaState extends State<DatosEmpresa> {
  Future<List> obtenerDatosEmpresa() async {
    var id = await FlutterSession().get('id');
    var url = "http://152.173.217.136/pruebastesis/obtenerDatosEmpresa.php";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(),
      body: new FutureBuilder<dynamic>(
        future: obtenerDatosEmpresa(),
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
    );
  }
}

class ElementoLista extends StatelessWidget {
  final List lista;

  ElementoLista({this.lista});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: lista == null ? 0 : lista.length,
      itemBuilder: (context, posicion) {
        return new Container(
          padding: EdgeInsets.all(2.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Title(
                    color: Colors.white,
                    child: Text(
                      "IndoStatus",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: 40.0,
                ),
                Title(
                    color: Colors.white,
                    child: Text(
                      "mision",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                Text(
                  lista[posicion]['Datos_mision'],
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Title(
                    color: Colors.white,
                    child: Text(
                      "Vision",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                Text(
                  lista[posicion]['Datos_vision'],
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Title(
                    color: Colors.white,
                    child: Text(
                      "Nosotros",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                Text(
                  lista[posicion]['Datos_comentario'],
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
