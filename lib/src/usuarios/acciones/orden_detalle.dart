import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class OrdenDetalle extends StatefulWidget {
  static const String ROUTE = "/ordenDetalle";
  final String id;

  const OrdenDetalle({Key key, this.id, int index, List lista})
      : super(key: key);

  @override
  _OrdenDetalleState createState() => _OrdenDetalleState();
}

class _OrdenDetalleState extends State<OrdenDetalle> {
  Future<List> obtenerInstalaciones() async {
    var id = await FlutterSession().get('id');
    var orden = ModalRoute.of(context).settings.arguments as String;
    var url =
        "http://152.173.217.136/pruebastesis/detalleOrdenes.php?Usuario_id=$id&Orden_id=$orden";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              FutureBuilder<dynamic>(
                future: obtenerInstalaciones(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData && snapshot.hasError)
                    print(snapshot.error);
                  return snapshot.hasData
                      ? new ElementoLista(
                          lista: snapshot.data,
                        )
                      : new Center(
                          child: new CircularProgressIndicator(),
                        );
                },
              ),
            ],
          ),
        ),
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
      shrinkWrap: true,
      physics: PageScrollPhysics(),
      itemCount: lista == null ? 0 : lista.length,
      itemBuilder: (context, posicion) {
        return new Container(
          padding: EdgeInsets.all(2.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Title(
                    color: Colors.white,
                    child: Text(
                      "Orden de Producto",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  "Nombre Cliente: " "" + lista[posicion]['Usuario_nombre'],
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "Fecha de instalacion: " "" + lista[posicion]['Orden_Fecha'],
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "Nombre Producto: " "" + lista[posicion]['Producto_nombre'],
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "Cantidad Productos: " "" +
                      lista[posicion]['Orden_cantidad_productos'],
                  style: TextStyle(fontSize: 25, color: Colors.white),
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
