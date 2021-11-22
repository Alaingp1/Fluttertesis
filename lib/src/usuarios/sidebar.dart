import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/home.dart';
import 'package:flutter_tesisv2/login.dart';
import 'package:flutter_tesisv2/src/empresa/contacto.dart';
import 'package:flutter_tesisv2/src/empresa/datos_empresa.dart';
import 'package:flutter_tesisv2/src/usuarios/ListadoOrdenes.dart';
import 'package:flutter_tesisv2/src/productos/productos.dart';
import 'package:flutter_tesisv2/src/usuarios/usuarios.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  List dataUsuario = [];
  int indexUsuario;

  @override
  void initState() {
    verUsuario().then((value) {
      dataUsuario = value;

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: GestureDetector(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: 40,
                      child: ClipOval(
                        child: dataUsuario.length >= 1
                            ? dataUsuario[0]['Usuario_foto'] != null
                                ? FadeInImage(
                                    image: NetworkImage(
                                        dataUsuario[0]['Usuario_foto']),
                                    placeholder:
                                        AssetImage('assets/jar-loading.gif'),
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    "assets/no-image.png",
                                    fit: BoxFit.fill,
                                  )
                            : Image.asset(
                                "assets/no-image.png",
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("   " + "   " + "Perfil"),
                  )
                ],
              ),
              onTap: () => {Navigator.pushNamed(context, Cuenta.ROUTE)},
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.home),
            title: Text('Inicio'),
            onTap: () => {Navigator.pushNamed(context, Home.ROUTE)},
          ),
          SizedBox(
            height: 40.0,
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.box),
            title: Text('Productos'),
            onTap: () => {Navigator.pushNamed(context, Productos.ROUTE)},
          ),
          SizedBox(
            height: 40.0,
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.list),
            title: Text('Ordenes'),
            onTap: () => {Navigator.pushNamed(context, ListadoOrdenes.ROUTE)},
          ),
          SizedBox(
            height: 40.0,
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.envira),
            title: Text('IndoStatus'),
            onTap: () => {Navigator.pushNamed(context, DatosEmpresa.ROUTE)},
          ),
          SizedBox(
            height: 40.0,
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.addressCard),
            title: Text('Contacto'),
            onTap: () => {Navigator.pushNamed(context, Contacto.ROUTE)},
          ),
          SizedBox(
            height: 40.0,
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.signOutAlt),
            title: Text('salir'),
            onTap: () => {Navigator.pushNamed(context, Login.ROUTE)},
          ),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }

  Future<List> verUsuario() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://192.168.1.81/pruebastesis/obtenerUsuario.php?Usuario_id=$id";
    final response = await http.get(Uri.parse(url));
    final dataUsuario = jsonDecode(response.body);

    return dataUsuario;
  }
}
