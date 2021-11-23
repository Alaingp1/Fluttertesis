import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/api.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/detalle_cultivos.dart';
import 'package:flutter_tesisv2/src/cultivos/cultivos.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class EditarCultivo extends StatefulWidget {
  static const String ROUTE = "/editarcultivo";
  @override
  _EditarCultivoState createState() => _EditarCultivoState();
}

class _EditarCultivoState extends State<EditarCultivo> {
  List dataTipo = [];
  List dataCult = [];
  String urlIma;
  int index;
  String dropdownValue;

  @override
  void initState() {
    verCultivos().then((value) {
      dataCult = value;
      setState(() {});
    });

    obtenerTipo().then((value) {
      dataTipo = value;
      setState(() {});
    });

    super.initState();
  }

  TextEditingController apodoController = TextEditingController();
  final foto = ImagePicker();
  File fotoi;
  String fotoN;

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: dataCult.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 300.0,
                  height: 300.0,
                  child: dataCult[index]['Cultivo_imagen'] != null &&
                          fotoi == null
                      ? FadeInImage(
                          image:
                              NetworkImage(dataCult[index]['Cultivo_imagen']),
                          placeholder: AssetImage('assets/jar-loading.gif'),
                        )
                      : fotoi != null
                          ? Image.file(fotoi)
                          : Image.asset(
                              "assets/no-image.png",
                              fit: BoxFit.fill,
                            ),
                ),
                Text(
                  "Nombre del Cultivo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Container(
                  child: TextFormField(
                    controller: apodoController,
                    decoration: InputDecoration(
                        labelText: dataCult[index]['Cultivo_apodo']),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                DropdownButton<String>(
                  hint: dataCult != null
                      ? Text(dataCult[index]['Tipo_nombre'])
                      : Text("ingrese un tipo de cultivo"),
                  value: dropdownValue,
                  underline: Container(
                    height: MediaQuery.of(context).size.height,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: dataTipo.map<DropdownMenuItem<String>>(
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
                ElevatedButton(
                  onPressed: () async {
                    if (fotoi != null && urlIma != null) {
                      await editarCultivo();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cultivo()));
                    } else {
                      Fluttertoast.showToast(
                          msg:
                              "por favor seleccione una imagen u espere un momento para que se suba");
                    }
                  },
                  child: Text("Editar"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future obtenerTipo() async {
    Uri url = Uri.parse(Api.obtipo);
    var response = await http.get(url);
    final dataj = jsonDecode(response.body);

    return dataj;
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

  Future<List> verCultivos() async {
    var id = await FlutterSession().get('id');
    var cultivo = ModalRoute.of(context).settings.arguments as String;
    var url =
        "http://152.173.217.136/pruebastesis/obtenerCultivoeditar.php?Usuario_id=$id&Cultivo_id=$cultivo";
    final response = await http.get(Uri.parse(url));
    final dataProd = jsonDecode(response.body);
    return dataProd;
  }

  void editarCultivo() async {
    var id = await FlutterSession().get('id');
    var cultivo = ModalRoute.of(context).settings.arguments as String;

    var url =
        "http://152.173.217.136/pruebastesis/editarCultivo.php?Cultivo_id=$cultivo&Tipo_id=$dropdownValue";
    http.post(Uri.parse(url), body: {
      'Cultivo_id': cultivo.toString(),
      'Cultivo_apodo': apodoController.text,
      'Cultivo_imagen': urlIma.toString(),
    });
  }
}
