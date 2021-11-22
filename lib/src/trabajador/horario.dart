import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter_session/flutter_session.dart';

class Horario extends StatefulWidget {
  static const String ROUTE = "/horario";
  final String id;

  const Horario({Key key, this.id}) : super(key: key);

  @override
  _HorarioState createState() => _HorarioState();
}

class _HorarioState extends State<Horario> {
  Future<Map> obtenerUsuarios() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://152.173.193.119/pruebastesis/obtenerHorario.php?Usuarioid=$id";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
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
            child: Text("Salir"),
          )
        ],
      ),
      body: ListView(children: [
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Text(
                  "Dia Lunes",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: new FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? new ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              Container(
                child: Text(
                  "Dia Martes",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: new FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? new ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              Container(
                child: Text(
                  "Dia Miercoles",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: new FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? new ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              Container(
                child: Text(
                  "Dia Jueves",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: new FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? new ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              Container(
                child: Text(
                  "Dia Viernes",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: new FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? new ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              Container(
                child: Text(
                  "Dia Sabado",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: new FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? new ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: TrabajadorBottomBar('horario'),
    );
  }
}

class ElementoLista extends StatelessWidget {
  final String inicio;
  final String cierre;

  const ElementoLista({Key key, this.inicio, this.cierre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 100,
      width: 220,
      padding: EdgeInsets.all(2.0),
      child: new GestureDetector(
        child: new Card(
          color: Colors.green,
          child: new Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Inicio:   " + inicio,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Cierre:   " + cierre,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
