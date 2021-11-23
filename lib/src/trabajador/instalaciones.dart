import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter_tesisv2/src/trabajador/acciones/instalaciones_detalle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Instalaciones extends StatefulWidget {
  static const String ROUTE = "/listausuarios";
  final String id;

  const Instalaciones({Key key, this.id}) : super(key: key);

  @override
  _InstalacionesState createState() => _InstalacionesState();
}

class _InstalacionesState extends State<Instalaciones> {
  Future<List> obtenerInstalaciones() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://152.173.217.136/pruebastesis/obtenerInstalaciones.php?Usuarioid=$id";
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
        future: obtenerInstalaciones(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ElementoLista(
                  lista: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      bottomNavigationBar: TrabajadorBottomBar('instalaciones'),
    );
  }
}

class ElementoLista extends StatelessWidget {
  final List lista;
  final int index;

  ElementoLista({this.lista, this.index});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lista == null ? 0 : lista.length,
      itemBuilder: (context, posicion) {
        return Container(
          padding: EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, "instalacionesdetalle",
                arguments: lista[posicion]['Instalacion_id']),
            child: Card(
              color: Colors.green,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Nombre Cliente: " "" + lista[posicion]['Usuario_nombre'],
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Direccion Cliente: " "" +
                          lista[posicion]['Usuario_direccion'],
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
