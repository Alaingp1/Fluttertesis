import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/api.dart';

import 'package:flutter_tesisv2/src/cultivos/cultivos.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class AgregarCultivo extends StatefulWidget {
  @override
  _AgregarCultivoState createState() => _AgregarCultivoState();
}

class _AgregarCultivoState extends State<AgregarCultivo> {
  final _formKey = GlobalKey<FormState>();
  List data = [];
  String urlIma;
  @override
  void initState() {
    // TODO: implement initState
    obtenerTipo().then((value) {
      data = value;
      setState(() {});
    });

    super.initState();
  }

  TextEditingController apodoController = TextEditingController();
  final foto = ImagePicker();
  File fotoi;
  String fotoN;
  String dropdownValue;

  @override
  Widget build(BuildContext casontext) {
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed("cultivos");
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              _tomarFoto();
            },
          ),
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () {
              _seleccionarFoto();
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              _mostrarFoto(),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: apodoController,
                decoration: InputDecoration(labelText: 'Apodo del cultivo'),
                textInputAction: TextInputAction.next,
              ),
              DropdownButton<String>(
                hint: Text("ingrese un tipo de cultivo"),
                value: dropdownValue,
                underline: Container(
                  height: MediaQuery.of(context).size.height,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: data.map<DropdownMenuItem<String>>(
                  (value) {
                    return DropdownMenuItem<String>(
                      value: value["Tipo_id"],
                      child: Text(
                        value["Tipo_nombre"],
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ).toList(),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (fotoi != null && urlIma != null) {
                    if (apodoController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "por favor ingrese un apodo para el cultivo");
                    } else if (dropdownValue != null) {
                      await registrarcultivo();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cultivo()));
                    } else {
                      print(dropdownValue);
                      Fluttertoast.showToast(
                          msg: "por favor ingrese un tipo de cultivo");
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            "por favor seleccione una imagen u espere un momento para que se suba");
                  }
                },
                child: Text("Crear cultivo"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _mostrarFoto() {
    if (fotoi == null) {
      return SizedBox(
        height: 250,
        width: 250,
        child: Image.asset("assets/no-image.png"),
      );
    } else {
      return SizedBox(
        child: fotoi != null
            ? Image.file(fotoi)
            : Fluttertoast.showToast(msg: "por favor seleccione una imagen"),
        height: 300,
        width: 300,
      );
    }
  }

  Future _seleccionarFoto() async {
    final pickedFoto =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFoto != null) {
        fotoi = File(pickedFoto.path);
        subirImagenFB(context);
      } else {}
    });
  }

  Future _tomarFoto() async {
    final pickedFoto = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFoto != null) {
        fotoi = File(pickedFoto.path);
        subirImagenFB(context);
      } else {}
    });
  }

  Future subirImagenFB(BuildContext context) async {
    fotoN = path.basename(fotoi.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("subir")
        .child("/$fotoN");
    final metadata = firebase_storage.SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': fotoN},
    );

    firebase_storage.UploadTask subirTask;

    subirTask = ref.putFile(File(fotoi.path), metadata);

    firebase_storage.UploadTask task = await Future.value(subirTask);
    Future.value(subirTask).then((value) async {
      Reference imaRef =
          FirebaseStorage.instance.ref().child('subir').child('/$fotoN');
      urlIma = await imaRef.getDownloadURL();

      return {print("Upload file path ${value.ref.fullPath}")};
    }).onError((error, stackTrace) =>
        {print("Upload file path error ${error.toString()} ")});
  }

  Future obtenerTipo() async {
    Uri url = Uri.parse(Api.obtipo);
    var response = await http.get(url);
    final dataj = jsonDecode(response.body);

    return dataj;
  }

  Future registrarcultivo() async {
    var id = await FlutterSession().get('id');
    var url =
        'http://192.168.1.81/pruebastesis/Crearcultivo.php?Usuario_id=$id&Tipo_id=$dropdownValue';
    await http.post(Uri.parse(url), body: {
      'Cultivo_apodo': apodoController.text,
      'Cultivo_imagen': urlIma.toString(),
    });
  }
}
