import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/detalle_cultivos.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:http/http.dart' as http;

class Placa extends StatefulWidget {
  static const String ROUTE = '/conectarplaca';
  final String algo;

  const Placa({Key key, this.algo}) : super(key: key);
  @override
  _PlacaState createState() => _PlacaState();
}

class _PlacaState extends State<Placa> {
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
                Navigator.pushNamed(context, "cultivos");
              },
              child: const Text("aceptar"))
        ],
      ),
    );
  }

  void generarOrden() async {
    var cultivo = ModalRoute.of(context).settings.arguments as String;
    /*  print('vinculando placa ${macPlaca.text} al cultivo $cultivo'); */
    var cultivo1 = widget.algo;
    print('vinculando placa ${macPlaca.text} al cultivo $cultivo1');
    var url = "http://152.173.207.169/pruebastesis/agregarMac.php";
    // final response = await http.get(Uri.parse(url));
    await http.post(
      Uri.parse(url),
      body: {
        "Cultivo_id": cultivo1,
        "Sensores_nombre": macPlaca.text,
      },
    );
  }
}
