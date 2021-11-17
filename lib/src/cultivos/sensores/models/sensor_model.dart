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
    this.temperaturaMaxima,
    this.temperaturaMinima,
    this.humedad,
    this.estado,
  });

  int id;
  int temperaturaMaxima;
  int temperaturaMinima;
  int humedad;
  bool estado;

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        id: json["id"],
        temperaturaMaxima: json["Temperatura_maxima"],
        temperaturaMinima: json["Temperatura_minima"],
        humedad: json["Humedad"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Temperatura_maxima": temperaturaMaxima,
        "Temperatura_minima": temperaturaMinima,
        "Humedad": humedad,
        "estado": estado,
      };
}
