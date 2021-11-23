import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_tesisv2/src/cultivos/sensores/models/sensor_model.dart';
import 'package:http/http.dart' as http;


class SensorProvider {
  final FirebaseDatabase db = FirebaseDatabase.instance;  

  final databaseRef = FirebaseDatabase.instance.reference();
  final Future<FirebaseApp> _future = Firebase.initializeApp();

<<<<<<< HEAD
  Future obtenerPlaca() async {
    String url =
        "http://152.173.217.136/pruebastesis/obtenerPlaca.php?Sensores_id=21&Cultivo_id=19";
=======
  void asignarDatos(SensorModel sensor) {
    databaseRef.child('/${sensor.name}').update(sensor.toJson());
>>>>>>> 2ea19a59e8b483f82b7a218583e2427ce1aa3c66
  }
}
