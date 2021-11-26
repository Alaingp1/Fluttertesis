import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'dart:async';

class Contacto extends StatefulWidget {
  static const String ROUTE = "/contacto";
  final String id;

  const Contacto({Key key, this.id}) : super(key: key);

  @override
  _ContactoState createState() => _ContactoState();
}

class _ContactoState extends State<Contacto> {
  Future<List> obtenerContacto() async {
    var id = await FlutterSession().get('id');
    var url = "http://152.173.207.169/pruebastesis/obtenerContacto.php";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(),
      body: new FutureBuilder<dynamic>(
        future: obtenerContacto(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ElementoLista(
                  lista: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
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
      itemCount: lista == null ? 0 : lista.length,
      itemBuilder: (context, posicion) {
        return new Container(
          padding: EdgeInsets.all(2.0),
          child: new Card(
            color: Colors.purpleAccent,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    lista[posicion]['Contacto_nombre'],
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ListTile(
                      leading: FaIcon(FontAwesomeIcons.envelope),
                      title: Text(
                        lista[posicion]['Contacto_email'],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.left,
                      )),
                  ListTile(
                      leading: FaIcon(FontAwesomeIcons.phone),
                      title: Text(
                        lista[posicion]['Contacto_telefono'],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.left,
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
