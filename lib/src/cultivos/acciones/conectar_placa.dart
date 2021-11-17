import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';

class Placa extends StatefulWidget {
  @override
  _PlacaState createState() => _PlacaState();
}

class _PlacaState extends State<Placa> {
  TextEditingController wifinombre = TextEditingController();
  TextEditingController wificontrasena = TextEditingController();
  TextEditingController macPlaca = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavDrawer(),
      body: ListView(
        children: [
          TextFormField(
            controller: wifinombre,
            decoration:
                InputDecoration(labelText: 'Ingrese el nombre de su Wifi'),
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            controller: wificontrasena,
            decoration:
                InputDecoration(labelText: 'Ingrese su contraseña Wifi'),
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            controller: macPlaca,
            decoration:
                InputDecoration(labelText: 'Ingrese la MAC de su placa'),
            textInputAction: TextInputAction.next,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("aceptar"))
        ],
      ),
    );
  }
}
