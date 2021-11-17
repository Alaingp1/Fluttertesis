import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sensor extends StatefulWidget {
  final String nombre;

  const Sensor({Key key, this.nombre}) : super(key: key);
  @override
  _SensorState createState() => _SensorState();
}

class _SensorState extends State<Sensor> {
  List<String> allItemList = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

  List<String> checkedItemList = ['Green', 'Yellow'];
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
                Text('Sensor de ${widget.nombre}')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Activar notificaciones'),
                Switch(
                  onChanged: (value) => print('toggle sensor'),
                  activeColor: Colors.green,
                  value: true,
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.only(right: 60),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'cuanta agua lesho?',
                  suffixText: 'ml',
                ),
                enabled: true,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
