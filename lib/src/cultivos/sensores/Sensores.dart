import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/cultivos/sensores/models/sensor_model.dart';
import 'package:flutter_tesisv2/src/cultivos/sensores/providers/sensor_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sensores extends StatefulWidget {
  static const String ROUTE = "/Sensores";
  Sensores({Key key}) : super(key: key);

  @override
  _SensoresState createState() => _SensoresState();
}

class _SensoresState extends State<Sensores> {
  SensorModel sensor = SensorModel();
  final sensorProvider = SensorProvider();

  TextEditingController minima = TextEditingController();
  TextEditingController maxima = TextEditingController();
  TextEditingController humedad = TextEditingController();
  TextEditingController macAddress = TextEditingController();

  bool flag = false;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
        child: Column(
          children: [
            listaSensores(),
            ElevatedButton(
              onPressed: _submit,
              child: Text("asignar parametros"),
            ),
          ],
        ),
      ),
    );
  }

  Widget listaSensores() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Activar notificaciones'),
            Switch(
              onChanged: (value) => setState(() {}),
              activeColor: Colors.green,
              value: sensor == null ? false : true,
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 60),
          child: TextField(
            controller: minima,
            decoration: InputDecoration(
              labelText: 'Sensores minima',
              suffixText: 'c°',
            ),
            enabled: true,
            keyboardType: TextInputType.number,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 60),
          child: TextField(
            controller: maxima,
            decoration: InputDecoration(
              labelText: 'Sensores maxima',
              suffixText: 'c°',
            ),
            enabled: true,
            keyboardType: TextInputType.number,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 60),
          child: TextField(
            controller: humedad,
            decoration: InputDecoration(
              labelText: 'Humedad de la planta',
              suffixText: '%',
            ),
            keyboardType: TextInputType.number,
          ),
        )
      ],
    );
  }

  void _submit() {
    sensor.sensoresMaxima = int.parse(minima.text);
    sensor.sensoresMinima = int.parse(maxima.text);
    sensor.humedad = int.parse(humedad.text);
    sensorProvider.obtenerPlaca();
  }

  void _setMacAdress() {
    print("macAddress " + macAddress.text);
    sensor.name = macAddress.text;
    setState(() {
      flag = true;
    });
  }
}
