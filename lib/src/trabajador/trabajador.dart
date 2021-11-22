import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';

class Trabajador extends StatefulWidget {
  static const String ROUTE = "/trabajador";
  final String id;

  const Trabajador({Key key, this.id}) : super(key: key);

  @override
  _TrabajadorState createState() => _TrabajadorState();
}

class _TrabajadorState extends State<Trabajador> {
  Future<Map> obtenerUsuarios() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://192.168.1.81/pruebastesis/obtenerHorario.php?Usuarioid=$id";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              Navigator.of(context).pushReplacementNamed("login");
            },
            child: Text("Salistesr"),
          )
        ],
      ),
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
                      Text(
                        "Nombre publicacion : " +
                            dataPub[index]['Publicacion_nombre'],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        "Autor : " + dataPub[index]['Usuario_nombre'],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
          );
        },
      ),
      bottomNavigationBar: TrabajadorBottomBar('trabajador'),
    );
  }

  Future<List> verPublicaciones() async {
    var url = "http://192.168.1.81/pruebastesis/obtenerPublicaciones.php";
    final response = await http.get(Uri.parse(url));
    final dataPub = jsonDecode(response.body);
    return dataPub;
  }
}
