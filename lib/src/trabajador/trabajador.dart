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
        "http://152.173.207.169/pruebastesis/obtenerHorario.php?Usuarioid=$id";
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
          var imagen = dataPub[index]['Publicacion_imagen'];
          Pattern urlima =
              r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
          RegExp regExp = RegExp(urlima);

          return Container(
            child: Card(
              color: Colors.indigo,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Titulo : " + dataPub[index]['Publicacion_nombre'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Autor : " + dataPub[index]['Usuario_nombre'],
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    height: 350,
                    width: 420,
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
                            "assets/logo.png",
                            height: 350,
                            fit: BoxFit.fitWidth,
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
      bottomNavigationBar: TrabajadorBottomBar('trabajador'),
    );
  }

  Future<List> verPublicaciones() async {
    var url = "http://152.173.207.169/pruebastesis/obtenerPublicaciones.php";
    final response = await http.get(Uri.parse(url));
    final dataPub = jsonDecode(response.body);
    return dataPub;
  }
}
