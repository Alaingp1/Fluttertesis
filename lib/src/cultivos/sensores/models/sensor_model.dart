// To parse this JSON data, do
//
//     final sensorModel = sensorModelFromJson(jsonString);

import 'dart:convert';

SensorModel sensorModelFromJson(String str) =>
    SensorModel.fromJson(json.decode(str));

String sensorModelToJson(SensorModel data) => json.encode(data.toJson());

class SensorModel {
  SensorModel({
    this.id,
    this.name,
    this.sensoresMaxima,
    this.sensoresMinima,
    this.humedad,
    this.estado,
  });

  int id;
  String name;
  int sensoresMaxima;
  int sensoresMinima;
  int humedad;
  bool estado;

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        id: json["id"],
        name: json["name"],
        sensoresMaxima: json["Sensores_maxima"],
        sensoresMinima: json["Sensores_minima"],
        humedad: json["Humedad"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "Sensores_maxima": sensoresMaxima,
        "Sensores_minima": sensoresMinima,
        "Humedad": humedad,
        "estado": estado,
      };
}
