import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/conectar_placa.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/editar_cultivo.dart';
import 'package:flutter_tesisv2/src/cultivos/cultivos.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';

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
        setState(() {});
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
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Divider(),
              Text(
                "Tipo del Cultivo:   " +
                    widget.listaCult[widget.indexCult]['Tipo_nombre'],
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
              datasensor == 0
                  ? Container(
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
                    )
                  : Container(),
              /*  Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   
                  ],
                ),
              ),
              datasensor != 0 */
              datasensor != 0
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
                  : Container()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.edit,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "editarcultivo",
                arguments: widget.listaCult[widget.indexCult]['Cultivo_id']);
          }),
      bottomNavigationBar: ClienteBottomBar('cultivos'),
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
        'http://152.173.207.169/pruebastesis/EliminarCultivo.php?Cultivo_id=$cultivoid';
    var response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  obtenerSensores() async {
    var id = await FlutterSession().get('id');
    String cultivoid = widget.listaCult[widget.indexCult]['Cultivo_id'];
    var url =
        'http://152.173.207.169/pruebastesis/obtenerSensores.php?Usuario_id=$id&Cultivo_id=$cultivoid';
    var response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }
}
