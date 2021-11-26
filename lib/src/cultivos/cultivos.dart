import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/agregar_cultivo.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/detalle_cultivos.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:http/http.dart' as http;

class Cultivo extends StatefulWidget {
  static const String ROUTE = '/cultivos';
  @override
  _CultivoState createState() => _CultivoState();
}

class _CultivoState extends State<Cultivo> {
  List dataCult = [];

  @override
  void initState() {
    verCultivos().then((value) {
      dataCult = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed("home");
          },
        ),
      ),
      body: ListView.builder(
        itemCount: dataCult.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => DetalleCultivo(
                    indexCult: index,
                    listaCult: dataCult,
                  ),
                ),
              );
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Nombre del cultivo : " +
                                dataCult[index]['Cultivo_apodo'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            "tipo del cultivo : " +
                                dataCult[index]['Tipo_nombre'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              margin: EdgeInsets.all(10),
                              width: 150.0,
                              height: 150.0,
                              child: FadeInImage(
                                image: NetworkImage(
                                    dataCult[index]['Cultivo_imagen']),
                                placeholder:
                                    AssetImage('assets/jar-loading.gif'),
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.indigo),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AgregarCultivo())),
      ),
      bottomNavigationBar: ClienteBottomBar('cultivos'),
    );
  }

  Future<List> verCultivos() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://152.173.207.169/pruebastesis/obtenerCultivo.php?Usuario_id=$id";
    final response = await http.get(Uri.parse(url));
    final dataProd = jsonDecode(response.body);
    return dataProd;
  }
}
