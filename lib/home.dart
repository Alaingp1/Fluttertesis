import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/cultivos/cultivos.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:flutter_tesisv2/src/usuarios/alertas.dart';

import 'package:flutter_tesisv2/src/usuarios/usuarios.dart';
import 'package:http/http.dart' as http;

import 'src/empresa/bottom_bar.dart';

class Home extends StatefulWidget {
  static const String ROUTE = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  final List _widgetOptions = [Cultivo(), Cuenta(), Alertas()];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "listapub");
              },
              icon: Icon(Icons.photo_album_rounded)),
        ],
      ),
      bottomNavigationBar: ClienteBottomBar('home'),
      body: ListView.builder(
        itemCount: dataPub.length,
        itemBuilder: (contex, index) {
          return Container(
            child: Card(
              child: Column(
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Titulo : " + dataPub[index]['Publicacion_nombre'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          Text(
                            "Autor : " + dataPub[index]['Usuario_nombre'],
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
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
                  Container(
                      child: Text(
                    dataPub[index]['Publicacion_descripcion'],
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )),
                  Divider()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List> verPublicaciones() async {
    var url = "http://152.173.193.119/pruebastesis/obtenerPublicaciones.php";
    final response = await http.get(Uri.parse(url));
    final dataPub = jsonDecode(response.body);
    return dataPub;
  }
}
