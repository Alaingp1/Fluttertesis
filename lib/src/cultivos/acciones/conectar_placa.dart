import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:http/http.dart' as http;

class Placa extends StatefulWidget {
  static const String ROUTE = '/conectarplaca';
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
            controller: macPlaca,
            decoration:
                InputDecoration(labelText: 'Ingrese la MAC de su placa'),
            textInputAction: TextInputAction.next,
          ),
          ElevatedButton(
              onPressed: () {
                generarOrden();
              },
              child: const Text("aceptar"))
        ],
      ),
    );
  }

  void generarOrden() async {
    var cultivo = ModalRoute.of(context).settings.arguments as String;
    print('vinculando placa ${macPlaca.text} al cultivo $cultivo');
    var url = "http://152.173.193.119/pruebastesis/agregarMac.php";
    // final response = await http.get(Uri.parse(url));
    await http.post(
      Uri.parse(url),
      body: {
        "Cultivo_id": cultivo,
        "Sensores_nombre": macPlaca.text,
      },
    );
  }
}
