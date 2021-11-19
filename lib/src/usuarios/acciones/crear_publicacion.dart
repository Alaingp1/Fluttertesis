import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Publicacion extends StatefulWidget {
  static const String ROUTE = '/publicacion';
  @override
  _PublicacionState createState() => _PublicacionState();
}

class _PublicacionState extends State<Publicacion> {
  Map dataCult;
  @override
  void initState() {
    verCultivos().then((value) {
      dataCult = value;

      setState(() {});
    });

    super.initState();
  }

  TextEditingController nombrepController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  File fotoi;
  String fotoN;
  String urlIma;
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed("home");
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
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Crea tu publicacion",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              _mostrarFoto(),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Nombre : ",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 2,
              ),
              TextFormField(
                controller: nombrepController,
                decoration: InputDecoration(
                  labelText: dataCult != null
                      ? dataCult['Cultivo_apodo']
                      : "ingrese un nombre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Descripcion : ",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 2,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                controller: descripcionController,
                maxLines: 4,
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (nombrepController.text == "" &&
                        descripcionController.text == "") {
                      Fluttertoast.showToast(
                          msg:
                              "por favor ingrese un nombre y una descripcion para la publicacion");
                    } else {
                      crearPublicacion();
                      Navigator.of(context).pushNamed("home");
                    }
                  },
                  child: Text('compartir publicacion'),
                ),
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
        child: dataCult != null
            ? FadeInImage(
                image: NetworkImage(dataCult['Cultivo_imagen']),
                placeholder: AssetImage('assets/jar-loading.gif'),
              )
            : Image.asset("assets/no-image.png"),
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
      firebase_storage.Reference imaRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('subir')
          .child('/$fotoN');
      urlIma = await imaRef.getDownloadURL();

      return {print("Upload file path ${value.ref.fullPath}")};
    }).onError((error, stackTrace) =>
        {print("Upload file path error ${error.toString()} ")});
  }

  Future<Map<String, dynamic>> verCultivos() async {
    var id = await FlutterSession().get('id');
    var cultivo = ModalRoute.of(context).settings.arguments;
    var url =
        "http://192.168.1.81/pruebastesis/obtenerCultivoeditar.php?Usuario_id=$id&Cultivo_id=$cultivo";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body)[0];
  }

  crearPublicacion() async {
    var id = await FlutterSession().get('id');
    var url =
        'http://192.168.1.81/pruebastesis/crearPublicacion.php?Usuario_id=$id';
    http.post(Uri.parse(url), body: {
      'Publicacion_nombre': nombrepController.text == null
          ? nombrepController.text.toString()
          : dataCult['Cultivo_apodo'],
      'Publicacion_descripcion': descripcionController.text,
      'Publicacion_imagen':
          urlIma != null ? urlIma.toString() : dataCult['Cultivo_imagen'],
    });
  }
}
