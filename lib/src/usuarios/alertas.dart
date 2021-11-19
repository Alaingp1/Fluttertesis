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
          ListTile(
            leading: const Icon(FontAwesomeIcons.landmark),
            title: const Text('Notificar falta de agua'),
            trailing: Switch(
              onChanged: (value) => print('toggle notification'),
              activeColor: Colors.green,
              value: true,
            ),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.compressArrowsAlt),
            title: const Text('Notificar Sensores extrema'),
            trailing: Switch(
              onChanged: (value) => print('toggle notification'),
              activeColor: Colors.green,
              value: true,
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClienteBottomBar('alertas'),
    );
  }
}
