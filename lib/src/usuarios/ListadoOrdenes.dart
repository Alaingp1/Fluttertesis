import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter_tesisv2/src/trabajador/acciones/instalaciones_detalle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ListadoOrdenes extends StatefulWidget {
  static const String ROUTE = "/listadoOrdenes";
  final String id;

  const ListadoOrdenes({Key key, this.id}) : super(key: key);

  @override
  _ListadoOrdenesState createState() => _ListadoOrdenesState();
}

class _ListadoOrdenesState extends State<ListadoOrdenes> {
  Future<List> obtenerOrdenes() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://152.173.207.169/pruebastesis/obtenerOrdenes.php?Usuario_id=$id";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, "home");
          },
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: obtenerOrdenes(),
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
          margin: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, "ordenDetalle",
                arguments: lista[posicion]['Orden_id']),
            child: Card(
              color: Color.fromRGBO(0, 165, 207, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Nombre: " "" + lista[posicion]['Producto_nombre'],
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Cantidad: " "" +
                          lista[posicion]['Orden_cantidad_productos'],
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      lista[posicion]['Detalle_fecha'],
                      style: TextStyle(fontSize: 15, color: Colors.black),
                      textAlign: TextAlign.center,
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
