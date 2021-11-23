import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/conectar_placa.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/editar_cultivo.dart';
import 'package:flutter_tesisv2/src/cultivos/cultivos.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class DetalleCultivo extends StatefulWidget {
  final int indexCult;

  final List listaCult;

  const DetalleCultivo({Key key, this.indexCult, this.listaCult})
      : super(key: key);

  @override
  _DetalleCultivoState createState() => _DetalleCultivoState();
}

class _DetalleCultivoState extends State<DetalleCultivo> {
  bool verificarsi = false;
  bool verificado = true;
  int datasensor = 0;
  @override
  void initState() {
    obtenerSensores().then((value) {
      if (value.length >= 1) {
        datasensor = int.parse(value[0]['Sensores_id']);
        print('sensor: $datasensor');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed("cultivos");
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              var url =
                  "http://152.173.217.136/pruebastesis/EliminarCultivo.php";
              await http.post(Uri.parse(url), body: {
                "Cultivo_id": widget.listaCult[widget.indexCult]['Cultivo_id']
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cultivo()));
            },
          ),
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, "editarcultivo",
                    arguments: widget.listaCult[widget.indexCult]
                        ['Cultivo_id']);
              }),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Navigator.pushNamed(context, "publicacion",
                  arguments: widget.listaCult[widget.indexCult]['Cultivo_id']);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          child: Column(
            children: [
              Text(
                "Nombre del Cultivo:   " +
                    widget.listaCult[widget.indexCult]['Cultivo_apodo'],
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Divider(),
              Text(
                "Tipo del Cultivo:   " +
                    widget.listaCult[widget.indexCult]['Tipo_nombre'],
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Divider(),
              Container(
                  height: 250,
                  width: 250,
                  child: FadeInImage(
                    image: NetworkImage(
                        widget.listaCult[widget.indexCult]['Cultivo_imagen']),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                  )),
              Divider(),
              Divider(),
<<<<<<< HEAD
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    datasensor == 0
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("adquiriste nuestro producto(?)"),
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "conectarplaca",
                                        arguments:
                                            widget.listaCult[widget.indexCult]
                                                ['Cultivo_id']);
                                  },
                                  child: Text("vincular")),
                            ],
                          )
                        : Container(
                            color: Colors.amber,
                          )
                  ],
                ),
              ),
              datasensor != 0
=======
              datasensor > 0
>>>>>>> 2ea19a59e8b483f82b7a218583e2427ce1aa3c66
                  ? Container(
                      child: ListBody(
                        children: [
                          Divider(),
                          ListTile(
                            leading: Icon(FontAwesomeIcons.thermometerQuarter),
                            title: Text('Sensor de Sensores'),
                            subtitle: Text('28ºC'),
                            trailing: Switch(
                              onChanged: (value) => print('toggle sensor'),
                              activeColor: Colors.green,
                              value: true,
                            ),
                            onTap: () => Navigator.pushNamed(
                                context, "Sensores",
                                arguments: widget.listaCult[widget.indexCult]
                                    ['Cultivo_id']),
                          ),
                          ListTile(
                            leading: Icon(FontAwesomeIcons.tint),
                            title: Text('Sensor de humedad'),
                            subtitle: Text('45%'),
                            trailing: Switch(
                              onChanged: (value) => print('toggle sensor'),
                              activeColor: Colors.green,
                              value: true,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("adquiriste nuestro producto(?)"),
                          ElevatedButton(
                              onPressed: () {
                                navigateToSubPage(context);
                              },
                              child: Text("vincular")),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future navigateToSubPage(context) async {
    String message = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Placa(
                  algo: widget.listaCult[widget.indexCult]['Cultivo_id'],
                )));
    print('mac resivida desde conectar: $message');
  }

  eliminarCultivo() async {
    String cultivoid = widget.listaCult[widget.indexCult]['Cultivo_id'];
    var url =
        'http://152.173.217.136/pruebastesis/EliminarCultivo.php?Cultivo_id=$cultivoid';
    var response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  obtenerSensores() async {
    var id = await FlutterSession().get('id');
    String cultivoid = widget.listaCult[widget.indexCult]['Cultivo_id'];
    var url =
        'http://152.173.217.136/pruebastesis/obtenerSensores.php?Usuario_id=$id&Cultivo_id=$cultivoid';
    var response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }
}
