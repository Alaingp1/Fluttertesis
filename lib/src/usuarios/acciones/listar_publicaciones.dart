import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/cultivos/cultivos.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter_tesisv2/src/usuarios/acciones/detalle_publicacion.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:flutter_tesisv2/src/usuarios/alertas.dart';

import 'package:flutter_tesisv2/src/usuarios/usuarios.dart';
import 'package:http/http.dart' as http;

class ListaPublicaciones extends StatefulWidget {
  static const String ROUTE = '/listapub';

  @override
  _ListaPublicacionesState createState() => _ListaPublicacionesState();
}

class _ListaPublicacionesState extends State<ListaPublicaciones> {
  int _currentIndex = 1;
  List dataPub = [];
  int indexPublicacion;

  @override
  void initState() {
    verPublicaciones().then((value) {
      dataPub = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pushNamed("home");
        },
      )),
      body: ListView.builder(
        itemCount: dataPub.length,
        itemBuilder: (contex, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => DetallePublicacion(
                    indexPub: index,
                    listaPub: dataPub,
                  ),
                ),
              );
            },
            child: Container(
              child: Card(
                child: Column(
                  children: [
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nombre publicacion : " +
                              dataPub[index]['Publicacion_nombre'],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          "Autor : " + dataPub[index]['Usuario_nombre'],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    Divider(),
                    Container(
                      child: dataPub[index]['Publicacion_imagen'] != null
                          ? FadeInImage(
                              image: NetworkImage(
                                  dataPub[index]['Publicacion_imagen']),
                              placeholder: AssetImage('assets/jar-loading.gif'),
                            )
                          : Image.asset(
                              "assets/no-image.png",
                              fit: BoxFit.fill,
                            ),
                    ),
                    Divider(),
                    Text(
                      "Descripcion: ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Divider(),
                    Container(
                        child: Text(
                      dataPub[index]['Publicacion_descripcion'],
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List> verPublicaciones() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://192.168.1.81/pruebastesis/obtenerPublicacionusuario.php?Usuario_id=$id";
    final response = await http.get(Uri.parse(url));
    final dataPub = jsonDecode(response.body);
    return dataPub;
  }
}
