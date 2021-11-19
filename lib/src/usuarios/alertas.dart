import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Alertas extends StatefulWidget {
  static const String ROUTE = "/alertas";
  @override
  _AlertasState createState() => _AlertasState();
}

class _AlertasState extends State<Alertas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      body: ListView(
        shrinkWrap: true,
        physics: PageScrollPhysics(),
        children: [
          Card(
            color: Colors.purple[800],
            child: Container(
              height: 50,
              child: Center(child: Text("te has registrado")),
            ),
          )
        ],
      ),
      bottomNavigationBar: ClienteBottomBar('alertas'),
    );
  }
}
