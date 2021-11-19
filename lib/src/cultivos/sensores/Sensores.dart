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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FaIcon(
                  FontAwesomeIcons.image,
                  size: 60,
                ),
                Text('Sensor de Sensores')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Activar notificaciones'),
                Switch(
                  onChanged: (value) => setState(() {
                    sensor.estado = value;
                  }),
                  activeColor: Colors.green,
                  value: sensor.estado,
                ),
              ],
            ),
            _minima(),
            _maxima(),
            _humedad(),
            ElevatedButton(
              onPressed: _submit,
              child: Text("asignar parametros"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _minima() {
    final node = FocusScope.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(right: 60),
      child: TextFormField(
        controller: minima,
        decoration: InputDecoration(
          labelText: 'Sensores minima',
          suffixText: 'c°',
        ),
        onFieldSubmitted: (value) {
          value = minima.text;
          sensor.SensoresMinima = int.parse(value);
          node.nextFocus();
        },
        enabled: true,
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _maxima() {
    final node = FocusScope.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(right: 60),
      child: TextFormField(
        controller: maxima,
        decoration: InputDecoration(
          labelText: 'Sensores maxima',
          suffixText: 'c°',
        ),
        onSaved: (value) {
          value = maxima.text;
          sensor.SensoresMaxima = int.parse(value);
          node.nextFocus();
        },
        enabled: true,
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _humedad() {
    final node = FocusScope.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(right: 60),
      child: TextFormField(
        controller: humedad,
        decoration: InputDecoration(
          labelText: 'Humedad de la planta',
          suffixText: '%',
        ),
        onFieldSubmitted: (value) {
          value = humedad.text;
          sensor.humedad = int.parse(value);
          node.nextFocus();
        },
        keyboardType: TextInputType.number,
      ),
    );
  }

  void _submit() {
    print("minima  " + minima.text);
    print("maxima  " + maxima.text);
    print("humedad " + humedad.text);
    print("minima  " + sensor.SensoresMinima.toString());
    print("maxima  " + sensor.SensoresMaxima.toString());
    print("humedad " + sensor.humedad.toString());

    sensorProvider.asignarDatos(sensor);
  }
}
