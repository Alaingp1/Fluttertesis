import 'package:flutter/cupertino.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:intl/intl.dart';

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
        "http://152.173.207.169/pruebastesis/detalleOrdenes.php?Usuario_id=$id&Orden_id=$orden";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 248, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
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
    return ListView.builder(
      shrinkWrap: true,
      physics: PageScrollPhysics(),
      itemCount: lista == null ? 0 : lista.length,
      itemBuilder: (context, posicion) {
        int preciototal = int.parse(lista[posicion]['Producto_precio']) *
            int.parse(lista[posicion]['Orden_cantidad_productos']);
        String total = NumberFormat("#,###")
            .format(preciototal)
            .toString()
            .replaceAll(",", ".");
        return Container(
          padding: EdgeInsets.all(25),
          child: Card(
            color: Color.fromRGBO(0, 165, 207, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Title(
                      color: Colors.white,
                      child: Text(
                        "Detalle del Pedido",
                        style: TextStyle(
                            fontSize: 27,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Title(
                        color: Colors.white,
                        child: Text(
                          "Datos Personales: ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Divider(),
                      Text(
                        "Nombre: " "" + lista[posicion]['Usuario_nombre'],
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Direccion: " "" + lista[posicion]['Usuario_direccion'],
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Telefono: " "" + lista[posicion]['Usuario_telefono'],
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Title(
                        color: Colors.white,
                        child: Text(
                          "Datos del Pedido: ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Producto: " "" + lista[posicion]['Producto_nombre'],
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Cantidad: " "" +
                            lista[posicion]['Orden_cantidad_productos'],
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Precio Total: \$" "" + total,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Fecha de instalacion: " +
                            lista[posicion]['Orden_Fecha'],
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Divider()
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    lista[posicion]['Detalle_fecha'],
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  Divider()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
