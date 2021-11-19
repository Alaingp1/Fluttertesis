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
    this.SensoresMaxima,
    this.SensoresMinima,
    this.humedad,
    this.estado,
  });

  int id;
  int SensoresMaxima;
  int SensoresMinima;
  int humedad;
  bool estado;

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        id: json["id"],
        SensoresMaxima: json["Sensores_maxima"],
        SensoresMinima: json["Sensores_minima"],
        humedad: json["Humedad"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Sensores_maxima": SensoresMaxima,
        "Sensores_minima": SensoresMinima,
        "Humedad": humedad,
        "estado": estado,
      };
}
