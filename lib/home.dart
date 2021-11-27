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
      backgroundColor: Color.fromRGBO(0, 165, 207, 1),
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
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
          var imagen = dataPub[index]['Publicacion_imagen'];
          Pattern urlima =
              r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
          RegExp regExp = RegExp(urlima);

          return Container(
            margin: EdgeInsets.all(8),
            child: Card(
              color: Color.fromRGBO(240, 248, 255, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "     Titulo : " + dataPub[index]['Publicacion_nombre'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "     Autor : " + dataPub[index]['Usuario_nombre'],
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: dataPub[index]['Publicacion_imagen'] != null
                        ? regExp.hasMatch(imagen)
                            ? FadeInImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                  dataPub[index]['Publicacion_imagen'],
                                ),
                                placeholder:
                                    AssetImage('assets/jar-loading.gif'),
                              )
                            : FadeInImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                    "http://152.173.207.169/lefufuapp/public/uploads/publicaciones/$imagen"),
                                placeholder:
                                    AssetImage('assets/jar-loading.gif'),
                              )
                        : Image.asset(
                            "assets/logo_fondo.png",
                            height: 350,
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                  Divider(),
                  Container(
                      child: Container(
                    width: 370,
                    child: Text(
                      dataPub[index]['Publicacion_descripcion'],
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  )),
                  Divider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List> verPublicaciones() async {
    var url = "http://152.173.207.169/pruebastesis/obtenerPublicaciones.php";
    final response = await http.get(Uri.parse(url));
    final dataPub = jsonDecode(response.body);
    return dataPub;
  }
}
