import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class InstalacionesDetalle extends StatefulWidget {
  static const String ROUTE = "/instalacionesdetalle";
  final String id;

  const InstalacionesDetalle({Key key, this.id, int index, List lista})
      : super(key: key);

  @override
  _InstalacionesDetalleState createState() => _InstalacionesDetalleState();
}

class _InstalacionesDetalleState extends State<InstalacionesDetalle> {
  Future<List> obtenerInstalaciones() async {
    var id = await FlutterSession().get('id');
    var instalacion = ModalRoute.of(context).settings.arguments as String;
    var url =
        "http://152.173.207.169/pruebastesis/detalleInstalaciones.php?Usuario_id=$id&Instalacion_id=$instalacion";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("login");
            },
            child: Text("Salir"),
          )
        ],
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
              ElevatedButton(
                  onPressed: () {
                    validarInstalacion();
                    setState(() {});
                    Navigator.of(context).pushReplacementNamed("instalaciones");
                  },
                  child: Text("validar")),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    eliminarInstalacion();
                    setState(() {});
                    Navigator.of(context).pushReplacementNamed("instalaciones");
                  },
                  child: Text("Eliminar")),
            ],
          ),
        ),
      ),
      bottomNavigationBar: TrabajadorBottomBar('instalaciones'),
    );
  }

  validarInstalacion() async {
    var instalacion = ModalRoute.of(context).settings.arguments as String;
    var url =
        "http://152.173.207.169/pruebastesis/validarInstalacion.php?Instalacion_id=$instalacion";
    final response = await http.get(Uri.parse(url));

    // http.post(Uri.parse(url), body: {});
  }

  eliminarInstalacion() async {
    var instalacion = ModalRoute.of(context).settings.arguments as String;
    var url =
        "http://152.173.207.169/pruebastesis/eliminarInstalacion.php?Instalacion_id=$instalacion";
    final response = await http.get(Uri.parse(url));
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
                      "Instalaciones",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  "Nombre Cliente: " "" + lista[posicion]['Usuario_nombre'],
                  style: TextStyle(fontSize: 25, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "Direccion Cliente: " "" +
                      lista[posicion]['Usuario_direccion'],
                  style: TextStyle(fontSize: 25, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "Nombre Producto: " "" + lista[posicion]['Producto_nombre'],
                  style: TextStyle(fontSize: 25, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "Cantidad Productos: " "" +
                      lista[posicion]['Orden_cantidad_productos'],
                  style: TextStyle(fontSize: 25, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                FlatButton(
                  child: Text(
                    'Reagendar',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  color: Colors.purple,
                  textColor: Colors.black,
                  onPressed: () => Navigator.pushNamed(
                      context, "reagendarinstalacion",
                      arguments: lista[posicion]['Orden_id']),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
